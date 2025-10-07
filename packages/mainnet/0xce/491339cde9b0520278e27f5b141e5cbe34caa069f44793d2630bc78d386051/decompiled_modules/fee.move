module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::fee {
    struct FEE has drop {
        dummy_field: bool,
    }

    struct FeeManager has store, key {
        id: 0x2::object::UID,
        dao_creation_fee: u64,
        proposal_creation_fee: u64,
        verification_fee: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct FeeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct DAOCreationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        admin: address,
        timestamp: u64,
    }

    struct ProposalCreationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        admin: address,
        timestamp: u64,
    }

    struct VerificationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        admin: address,
        timestamp: u64,
    }

    struct DAOCreationFeeCollected has copy, drop {
        amount: u64,
        payer: address,
        timestamp: u64,
    }

    struct ProposalCreationFeeCollected has copy, drop {
        amount: u64,
        payer: address,
        timestamp: u64,
    }

    struct VerificationFeeCollected has copy, drop {
        amount: u64,
        payer: address,
        timestamp: u64,
    }

    struct StableFeesCollected has copy, drop {
        amount: u64,
        stable_type: 0x1::ascii::String,
        proposal_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct StableFeesWithdrawn has copy, drop {
        amount: u64,
        stable_type: 0x1::ascii::String,
        recipient: address,
        timestamp: u64,
    }

    struct StableCoinBalance<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
    }

    struct StableFeeRegistry<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun deposit_dao_creation_payment(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg0.dao_creation_fee;
        let v1 = DAOCreationFeeCollected{
            amount    : deposit_payment(arg0, v0, arg1),
            payer     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DAOCreationFeeCollected>(v1);
    }

    fun deposit_payment(arg0: &mut FeeManager, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 == arg1, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        v0
    }

    public(friend) fun deposit_proposal_creation_payment(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg0.proposal_creation_fee;
        let v1 = ProposalCreationFeeCollected{
            amount    : deposit_payment(arg0, v0, arg1),
            payer     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProposalCreationFeeCollected>(v1);
    }

    public(friend) fun deposit_stable_fees<T0>(arg0: &mut FeeManager, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = StableFeeRegistry<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<StableFeeRegistry<T0>, StableCoinBalance<T0>>(&arg0.id, v0)) {
            let v1 = StableFeeRegistry<T0>{dummy_field: false};
            0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<StableFeeRegistry<T0>, StableCoinBalance<T0>>(&mut arg0.id, v1).balance, arg1);
        } else {
            let v2 = StableCoinBalance<T0>{balance: arg1};
            let v3 = StableFeeRegistry<T0>{dummy_field: false};
            0x2::dynamic_field::add<StableFeeRegistry<T0>, StableCoinBalance<T0>>(&mut arg0.id, v3, v2);
        };
        let v4 = StableFeesCollected{
            amount      : 0x2::balance::value<T0>(&arg1),
            stable_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            proposal_id : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StableFeesCollected>(v4);
    }

    public(friend) fun deposit_verification_payment(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg0.verification_fee;
        let v1 = VerificationFeeCollected{
            amount    : deposit_payment(arg0, v0, arg1),
            payer     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VerificationFeeCollected>(v1);
    }

    public fun get_dao_creation_fee(arg0: &FeeManager) : u64 {
        arg0.dao_creation_fee
    }

    public fun get_proposal_creation_fee(arg0: &FeeManager) : u64 {
        arg0.proposal_creation_fee
    }

    public fun get_stable_fee_balance<T0>(arg0: &FeeManager) : u64 {
        let v0 = StableFeeRegistry<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<StableFeeRegistry<T0>, StableCoinBalance<T0>>(&arg0.id, v0)) {
            let v2 = StableFeeRegistry<T0>{dummy_field: false};
            0x2::balance::value<T0>(&0x2::dynamic_field::borrow<StableFeeRegistry<T0>, StableCoinBalance<T0>>(&arg0.id, v2).balance)
        } else {
            0
        }
    }

    public fun get_sui_balance(arg0: &FeeManager) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun get_verification_fee(arg0: &FeeManager) : u64 {
        arg0.verification_fee
    }

    fun init(arg0: FEE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<FEE>(&arg0), 2);
        let v0 = FeeManager{
            id                    : 0x2::object::new(arg1),
            dao_creation_fee      : 20000000000,
            proposal_creation_fee : 10000000000,
            verification_fee      : 10000000000,
            sui_balance           : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = FeeAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<FeeManager>(v0);
        0x2::transfer::public_transfer<FeeAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun update_dao_creation_fee(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.dao_creation_fee = arg2;
        let v0 = DAOCreationFeeUpdated{
            old_fee   : arg0.dao_creation_fee,
            new_fee   : arg2,
            admin     : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DAOCreationFeeUpdated>(v0);
    }

    public entry fun update_proposal_creation_fee(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.proposal_creation_fee = arg2;
        let v0 = ProposalCreationFeeUpdated{
            old_fee   : arg0.proposal_creation_fee,
            new_fee   : arg2,
            admin     : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProposalCreationFeeUpdated>(v0);
    }

    public entry fun update_verification_fee(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.verification_fee = arg2;
        let v0 = VerificationFeeUpdated{
            old_fee   : arg0.verification_fee,
            new_fee   : arg2,
            admin     : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VerificationFeeUpdated>(v0);
    }

    public entry fun withdraw_all_fees(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = FeesWithdrawn{
            amount    : v0,
            recipient : v1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FeesWithdrawn>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0), arg3), v1);
    }

    public entry fun withdraw_stable_fees<T0>(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StableFeeRegistry<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<StableFeeRegistry<T0>, StableCoinBalance<T0>>(&arg0.id, v0), 1);
        let v1 = StableFeeRegistry<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<StableFeeRegistry<T0>, StableCoinBalance<T0>>(&mut arg0.id, v1);
        let v3 = 0x2::balance::value<T0>(&v2.balance);
        if (v3 > 0) {
            let v4 = StableFeesWithdrawn{
                amount      : v3,
                stable_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                recipient   : 0x2::tx_context::sender(arg3),
                timestamp   : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<StableFeesWithdrawn>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, v3), arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

