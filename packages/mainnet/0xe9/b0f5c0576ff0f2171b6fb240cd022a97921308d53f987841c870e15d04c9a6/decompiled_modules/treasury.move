module 0xe9b0f5c0576ff0f2171b6fb240cd022a97921308d53f987841c870e15d04c9a6::treasury {
    struct TreasuryConfig has key {
        id: 0x2::object::UID,
        admin: address,
        fees_bps: u64,
        beneficiary: address,
        collected_fees: 0x2::bag::Bag,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollected has copy, drop {
        coin_type: vector<u8>,
        amount: u64,
        payer: address,
    }

    struct FeeWithdrawn has copy, drop {
        coin_type: vector<u8>,
        amount: u64,
        recipient: address,
        withdrawn_by: address,
    }

    struct AdminUpdated has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct FeesBpsUpdated has copy, drop {
        old_fees_bps: u64,
        new_fees_bps: u64,
    }

    struct BeneficiaryUpdated has copy, drop {
        old_beneficiary: address,
        new_beneficiary: address,
    }

    public fun calculate_fee(arg0: &TreasuryConfig, arg1: u64) : u64 {
        arg1 * arg0.fees_bps / 10000
    }

    public fun deposit_fee<T0>(arg0: &mut TreasuryConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        if (0x2::bag::contains<vector<u8>>(&arg0.collected_fees, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.collected_fees, v1), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.collected_fees, v1, 0x2::coin::into_balance<T0>(arg1));
        };
        let v2 = FeeCollected{
            coin_type : v1,
            amount    : 0x2::coin::value<T0>(&arg1),
            payer     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeCollected>(v2);
    }

    public fun deposit_fee_to_beneficiary<T0>(arg0: &TreasuryConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        let v1 = FeeCollected{
            coin_type : *0x1::ascii::as_bytes(&v0),
            amount    : 0x2::coin::value<T0>(&arg1),
            payer     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeCollected>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.beneficiary);
    }

    public fun get_admin(arg0: &TreasuryConfig) : address {
        arg0.admin
    }

    public fun get_beneficiary(arg0: &TreasuryConfig) : address {
        arg0.beneficiary
    }

    public fun get_collected_balance<T0>(arg0: &TreasuryConfig) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        if (0x2::bag::contains<vector<u8>>(&arg0.collected_fees, v1)) {
            0x2::balance::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.collected_fees, v1))
        } else {
            0
        }
    }

    public fun get_fees_bps(arg0: &TreasuryConfig) : u64 {
        arg0.fees_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = TreasuryConfig{
            id             : 0x2::object::new(arg0),
            admin          : v0,
            fees_bps       : 0,
            beneficiary    : v0,
            collected_fees : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<TreasuryConfig>(v1);
        let v2 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TreasuryCap>(v2, v0);
    }

    public fun update_admin(arg0: &TreasuryCap, arg1: &mut TreasuryConfig, arg2: address) {
        arg1.admin = arg2;
        let v0 = AdminUpdated{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminUpdated>(v0);
    }

    public fun update_beneficiary(arg0: &TreasuryCap, arg1: &mut TreasuryConfig, arg2: address) {
        arg1.beneficiary = arg2;
        let v0 = BeneficiaryUpdated{
            old_beneficiary : arg1.beneficiary,
            new_beneficiary : arg2,
        };
        0x2::event::emit<BeneficiaryUpdated>(v0);
    }

    public fun update_fees_bps(arg0: &TreasuryCap, arg1: &mut TreasuryConfig, arg2: u64) {
        assert!(arg2 <= 10000, 1);
        arg1.fees_bps = arg2;
        let v0 = FeesBpsUpdated{
            old_fees_bps : arg1.fees_bps,
            new_fees_bps : arg2,
        };
        0x2::event::emit<FeesBpsUpdated>(v0);
    }

    public fun withdraw_all_fees<T0>(arg0: &TreasuryCap, arg1: &mut TreasuryConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        if (!0x2::bag::contains<vector<u8>>(&arg1.collected_fees, v1)) {
            return
        };
        let v2 = 0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.collected_fees, v1);
        let v3 = 0x2::balance::value<T0>(v2);
        if (v3 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, v3), arg3), arg2);
        let v4 = FeeWithdrawn{
            coin_type    : v1,
            amount       : v3,
            recipient    : arg2,
            withdrawn_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeWithdrawn>(v4);
    }

    public fun withdraw_fees<T0>(arg0: &TreasuryCap, arg1: &mut TreasuryConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        assert!(0x2::bag::contains<vector<u8>>(&arg1.collected_fees, v1), 2);
        let v2 = 0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.collected_fees, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg2), arg4), arg3);
        let v3 = FeeWithdrawn{
            coin_type    : v1,
            amount       : arg2,
            recipient    : arg3,
            withdrawn_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeeWithdrawn>(v3);
    }

    // decompiled from Move bytecode v6
}

