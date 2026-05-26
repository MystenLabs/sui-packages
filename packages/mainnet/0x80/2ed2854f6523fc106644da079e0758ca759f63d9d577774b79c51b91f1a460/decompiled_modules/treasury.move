module 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury {
    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        payout_balance: 0x2::balance::Balance<T0>,
        payout_address: address,
        owner: address,
        operators: vector<address>,
        partner_admin: 0x1::option::Option<address>,
        bond_contracts: 0x2::table::Table<address, BondContractConfig>,
        total_deposited: u128,
        total_withdrawn: u128,
        total_fees_collected: u128,
        max_payout_per_tx: u64,
        daily_payout_limit: u64,
        daily_payout_used: u64,
        last_limit_reset: u64,
        created_at: u64,
        name: vector<u8>,
    }

    struct BondContractConfig has copy, drop, store {
        enabled: bool,
        total_deposited: u128,
        total_withdrawn: u128,
        max_payout_per_tx: u64,
    }

    struct TreasuryCreatedEvent has copy, drop {
        treasury: address,
        payout_address: address,
        owner: address,
        name: vector<u8>,
        created_at: u64,
    }

    struct BondContractToggledEvent has copy, drop {
        treasury: address,
        bond_contract: address,
        enabled: bool,
        operator: address,
    }

    struct DepositEvent has copy, drop {
        treasury: address,
        bond_contract: address,
        amount_principal_token: u64,
        amount_payout_token: u64,
        fee_payout_token: u64,
    }

    struct WithdrawEvent has copy, drop {
        treasury: address,
        token_type: vector<u8>,
        destination: address,
        amount: u64,
        operator: address,
    }

    struct PartnerAdminSetEvent has copy, drop {
        treasury: address,
        old_partner_admin: 0x1::option::Option<address>,
        new_partner_admin: 0x1::option::Option<address>,
        setter: address,
    }

    struct SetPayoutAddressEvent has copy, drop {
        treasury: address,
        old_payout_address: address,
        new_payout_address: address,
    }

    struct OwnershipTransferredEvent has copy, drop {
        treasury: address,
        old_owner: address,
        new_owner: address,
    }

    public fun bond_contract_max_payout<T0>(arg0: &Treasury<T0>, arg1: address) : u64 {
        assert!(0x2::table::contains<address, BondContractConfig>(&arg0.bond_contracts, arg1), 4);
        0x2::table::borrow<address, BondContractConfig>(&arg0.bond_contracts, arg1).max_payout_per_tx
    }

    public fun create<T0>(arg0: vector<u8>, arg1: address, arg2: vector<address>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg1 != @0x0, 1);
        assert!(arg3 > 0, 13);
        assert!(arg4 > 0, 13);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v2 = Treasury<T0>{
            id                   : 0x2::object::new(arg6),
            payout_balance       : 0x2::balance::zero<T0>(),
            payout_address       : arg1,
            owner                : v0,
            operators            : arg2,
            partner_admin        : 0x1::option::none<address>(),
            bond_contracts       : 0x2::table::new<address, BondContractConfig>(arg6),
            total_deposited      : 0,
            total_withdrawn      : 0,
            total_fees_collected : 0,
            max_payout_per_tx    : arg3,
            daily_payout_limit   : arg4,
            daily_payout_used    : 0,
            last_limit_reset     : v1,
            created_at           : v1,
            name                 : arg0,
        };
        let v3 = 0x2::object::id_address<Treasury<T0>>(&v2);
        let v4 = TreasuryCreatedEvent{
            treasury       : v3,
            payout_address : arg1,
            owner          : v0,
            name           : arg0,
            created_at     : v1,
        };
        0x2::event::emit<TreasuryCreatedEvent>(v4);
        0x2::transfer::share_object<Treasury<T0>>(v2);
        v3
    }

    public fun deposit_with_fee<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        reset_daily_limits_if_needed<T0>(arg0, arg5);
        assert!(0x2::table::contains<address, BondContractConfig>(&arg0.bond_contracts, arg1), 4);
        let v0 = 0x2::table::borrow<address, BondContractConfig>(&arg0.bond_contracts, arg1);
        assert!(v0.enabled, 4);
        let v1 = arg3 + arg4;
        assert!(v1 <= v0.max_payout_per_tx, 8);
        assert!(v1 <= arg0.max_payout_per_tx, 8);
        assert!(arg0.daily_payout_used + v1 <= arg0.daily_payout_limit, 8);
        assert!(0x2::balance::value<T0>(&arg0.payout_balance) >= v1, 8);
        let v2 = if (arg4 > 0) {
            arg0.total_fees_collected = arg0.total_fees_collected + (arg4 as u128);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_balance, arg4), arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        arg0.total_deposited = arg0.total_deposited + (arg2 as u128);
        arg0.daily_payout_used = arg0.daily_payout_used + v1;
        let v3 = 0x2::table::borrow_mut<address, BondContractConfig>(&mut arg0.bond_contracts, arg1);
        v3.total_deposited = v3.total_deposited + (arg2 as u128);
        v3.total_withdrawn = v3.total_withdrawn + (arg3 as u128);
        let v4 = DepositEvent{
            treasury               : 0x2::object::id_address<Treasury<T0>>(arg0),
            bond_contract          : arg1,
            amount_principal_token : arg2,
            amount_payout_token    : arg3,
            fee_payout_token       : arg4,
        };
        0x2::event::emit<DepositEvent>(v4);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_balance, arg3), arg6), v2)
    }

    public fun fund<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.payout_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_created_at<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.created_at
    }

    public fun get_daily_payout_limit<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.daily_payout_limit
    }

    public fun get_daily_payout_used<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.daily_payout_used
    }

    public fun get_max_payout_per_tx<T0>(arg0: &Treasury<T0>) : u64 {
        arg0.max_payout_per_tx
    }

    public fun get_name<T0>(arg0: &Treasury<T0>) : vector<u8> {
        arg0.name
    }

    public fun get_owner<T0>(arg0: &Treasury<T0>) : address {
        arg0.owner
    }

    public fun get_partner_admin<T0>(arg0: &Treasury<T0>) : 0x1::option::Option<address> {
        arg0.partner_admin
    }

    public fun get_payout_address<T0>(arg0: &Treasury<T0>) : address {
        arg0.payout_address
    }

    public fun get_total_deposited<T0>(arg0: &Treasury<T0>) : u128 {
        arg0.total_deposited
    }

    public fun get_total_fees_collected<T0>(arg0: &Treasury<T0>) : u128 {
        arg0.total_fees_collected
    }

    public fun get_total_withdrawn<T0>(arg0: &Treasury<T0>) : u128 {
        arg0.total_withdrawn
    }

    public fun info<T0>(arg0: &Treasury<T0>) : (address, u128, u128, u64, u64) {
        (arg0.payout_address, arg0.total_deposited, arg0.total_withdrawn, arg0.daily_payout_used, arg0.daily_payout_limit)
    }

    public fun is_bond_contract_enabled<T0>(arg0: &Treasury<T0>, arg1: address) : bool {
        0x2::table::contains<address, BondContractConfig>(&arg0.bond_contracts, arg1) && 0x2::table::borrow<address, BondContractConfig>(&arg0.bond_contracts, arg1).enabled
    }

    public fun is_bond_contract_whitelisted<T0>(arg0: &Treasury<T0>, arg1: address) : bool {
        0x2::table::contains<address, BondContractConfig>(&arg0.bond_contracts, arg1)
    }

    public fun payout_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.payout_balance)
    }

    fun reset_daily_limits_if_needed<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v0 >= arg0.last_limit_reset + 86400) {
            arg0.daily_payout_used = 0;
            arg0.last_limit_reset = v0;
        };
    }

    public fun set_partner_admin<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x1::option::is_some<address>(&arg0.partner_admin)) {
            assert!(v0 == *0x1::option::borrow<address>(&arg0.partner_admin), 12);
        } else {
            assert!(v0 == arg0.owner, 12);
        };
        if (arg1 == @0x0) {
            arg0.partner_admin = 0x1::option::none<address>();
        } else {
            arg0.partner_admin = 0x1::option::some<address>(arg1);
        };
        let v1 = PartnerAdminSetEvent{
            treasury          : 0x2::object::id_address<Treasury<T0>>(arg0),
            old_partner_admin : arg0.partner_admin,
            new_partner_admin : arg0.partner_admin,
            setter            : v0,
        };
        0x2::event::emit<PartnerAdminSetEvent>(v1);
    }

    public fun set_payout_address<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(arg1 != @0x0, 1);
        arg0.payout_address = arg1;
        let v0 = SetPayoutAddressEvent{
            treasury           : 0x2::object::id_address<Treasury<T0>>(arg0),
            old_payout_address : arg0.payout_address,
            new_payout_address : arg1,
        };
        0x2::event::emit<SetPayoutAddressEvent>(v0);
    }

    public fun transfer_ownership<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg0.owner;
        assert!(0x2::tx_context::sender(arg2) == v0, 2);
        assert!(arg1 != @0x0, 1);
        arg0.owner = arg1;
        let v1 = OwnershipTransferredEvent{
            treasury  : 0x2::object::id_address<Treasury<T0>>(arg0),
            old_owner : v0,
            new_owner : arg1,
        };
        0x2::event::emit<OwnershipTransferredEvent>(v1);
    }

    public fun transfer_payout_to_payout_address<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        assert!(0x2::table::contains<address, BondContractConfig>(&arg0.bond_contracts, arg1), 4);
        assert!(0x2::table::borrow<address, BondContractConfig>(&arg0.bond_contracts, arg1).enabled, 4);
        let v0 = arg2;
        let v1 = 0x2::balance::value<T0>(&arg0.payout_balance);
        if (arg2 > v1) {
            v0 = v1;
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_balance, v0), arg3), arg0.payout_address);
        };
    }

    public fun update_limits<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(arg1 > 0, 13);
        assert!(arg2 > 0, 13);
        arg0.max_payout_per_tx = arg1;
        arg0.daily_payout_limit = arg2;
    }

    public fun whitelist_bond_contract<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: bool, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner || 0x1::vector::contains<address>(&arg0.operators, &v0), 3);
        if (0x2::table::contains<address, BondContractConfig>(&arg0.bond_contracts, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, BondContractConfig>(&mut arg0.bond_contracts, arg1);
            assert!(v1.enabled != arg2, 5);
            v1.enabled = arg2;
        } else {
            let v2 = BondContractConfig{
                enabled           : arg2,
                total_deposited   : 0,
                total_withdrawn   : 0,
                max_payout_per_tx : arg3,
            };
            0x2::table::add<address, BondContractConfig>(&mut arg0.bond_contracts, arg1, v2);
        };
        let v3 = BondContractToggledEvent{
            treasury      : 0x2::object::id_address<Treasury<T0>>(arg0),
            bond_contract : arg1,
            enabled       : arg2,
            operator      : v0,
        };
        0x2::event::emit<BondContractToggledEvent>(v3);
    }

    public fun withdraw_payout_token<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x1::option::is_some<address>(&arg0.partner_admin)) {
            assert!(v0 == *0x1::option::borrow<address>(&arg0.partner_admin), 12);
        } else {
            assert!(v0 == arg0.owner, 12);
        };
        assert!(0x2::balance::value<T0>(&arg0.payout_balance) >= arg1, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_balance, arg1), arg3), arg2);
        arg0.total_withdrawn = arg0.total_withdrawn + (arg1 as u128);
        let v1 = WithdrawEvent{
            treasury    : 0x2::object::id_address<Treasury<T0>>(arg0),
            token_type  : b"payout",
            destination : arg2,
            amount      : arg1,
            operator    : v0,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

