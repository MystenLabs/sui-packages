module 0x770374a78cc2ea0b8a939aa0d433e69dc5b35412399cb0d039ca88bd01a9fc26::authority {
    struct MasterCap has key {
        id: 0x2::object::UID,
    }

    struct KaiKeychain has key {
        id: 0x2::object::UID,
        whusdce_vault_admin_cap: 0x1::option::Option<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>>,
        scallop_whusdce_admin_cap: 0x1::option::Option<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>,
        profit_compound_allowlist: 0x2::vec_set::VecSet<address>,
        rebalance_allowlist: 0x2::vec_set::VecSet<address>,
    }

    entry fun add_address_to_profit_compound_allowlist(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.profit_compound_allowlist, arg2);
    }

    entry fun add_address_to_rebalance_allowlist(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.rebalance_allowlist, arg2);
    }

    fun assert_compound_allowlist(arg0: &KaiKeychain, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.profit_compound_allowlist, &v0), 0);
    }

    fun assert_rebalance_allowlist(arg0: &KaiKeychain, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.rebalance_allowlist, &v0), 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MasterCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = KaiKeychain{
            id                        : 0x2::object::new(arg0),
            whusdce_vault_admin_cap   : 0x1::option::none<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>>(),
            scallop_whusdce_admin_cap : 0x1::option::none<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>(),
            profit_compound_allowlist : 0x2::vec_set::empty<address>(),
            rebalance_allowlist       : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<KaiKeychain>(v1);
    }

    public fun master_borrow_scallop_whusdce_admin_cap(arg0: &MasterCap, arg1: &mut KaiKeychain) : &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap {
        0x1::option::borrow<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>(&arg1.scallop_whusdce_admin_cap)
    }

    public fun master_borrow_whusdce_vault_admin_cap(arg0: &MasterCap, arg1: &mut KaiKeychain) : &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE> {
        0x1::option::borrow<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>>(&arg1.whusdce_vault_admin_cap)
    }

    entry fun put_scallop_whusdce_admin_cap(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap) {
        0x1::option::fill<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>(&mut arg1.scallop_whusdce_admin_cap, arg2);
    }

    entry fun put_whusdce_vault_admin_cap(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>) {
        0x1::option::fill<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>>(&mut arg1.whusdce_vault_admin_cap, arg2);
    }

    entry fun remove_address(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg1.profit_compound_allowlist, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.profit_compound_allowlist, &arg2);
        };
        if (0x2::vec_set::contains<address>(&arg1.rebalance_allowlist, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.rebalance_allowlist, &arg2);
        };
    }

    entry fun remove_address_from_profit_compound_allowlist(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.profit_compound_allowlist, &arg2);
    }

    entry fun remove_address_from_rebalance_allowlist(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.rebalance_allowlist, &arg2);
    }

    entry fun rotate_address(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: address, arg3: address) {
        if (0x2::vec_set::contains<address>(&arg1.profit_compound_allowlist, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.profit_compound_allowlist, &arg2);
            0x2::vec_set::insert<address>(&mut arg1.profit_compound_allowlist, arg3);
        };
        if (0x2::vec_set::contains<address>(&arg1.rebalance_allowlist, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.rebalance_allowlist, &arg2);
            0x2::vec_set::insert<address>(&mut arg1.rebalance_allowlist, arg3);
        };
    }

    public fun scallop_whusdce_deposit_sold_profits(arg0: &KaiKeychain, arg1: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::Strategy, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>, arg3: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_compound_allowlist(arg0, arg5);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::deposit_sold_profits(0x1::option::borrow<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>(&arg0.scallop_whusdce_admin_cap), arg1, arg2, arg3, arg4);
    }

    public fun scallop_whusdce_rebalance(arg0: &KaiKeychain, arg1: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::Strategy, arg2: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::Vault<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>, arg3: &0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::RebalanceAmounts, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_rebalance_allowlist(arg0, arg8);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::rebalance(0x1::option::borrow<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>(&arg0.scallop_whusdce_admin_cap), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun scallop_whusdce_take_profits_for_selling(arg0: &KaiKeychain, arg1: &mut 0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::Strategy, arg2: 0x1::option::Option<u64>, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert_compound_allowlist(arg0, arg6);
        0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::take_profits_for_selling(0x1::option::borrow<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>(&arg0.scallop_whusdce_admin_cap), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    entry fun take_scallop_whusdce_admin_cap(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>(0x1::option::extract<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::scallop_whusdce::AdminCap>(&mut arg1.scallop_whusdce_admin_cap), 0x2::tx_context::sender(arg2));
    }

    entry fun take_whusdce_vault_admin_cap(arg0: &MasterCap, arg1: &mut KaiKeychain, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>>(0x1::option::extract<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::vault::AdminCap<0x1c389a85310b47e7630a9361d4e71025bc35e4999d3a645949b1b68b26f2273::ywhusdce::YWHUSDCE>>(&mut arg1.whusdce_vault_admin_cap), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

