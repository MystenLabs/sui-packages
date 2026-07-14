module 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::vault {
    struct EscrowEntry has store {
        nft: 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT,
        depositor: address,
        deposited_at_ms: u64,
    }

    struct GoldVault has key {
        id: 0x2::object::UID,
        inventory: 0x2::object_table::ObjectTable<0x2::object::ID, 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>,
        available: 0x2::table::Table<u8, vector<0x2::object::ID>>,
        escrow: 0x2::table::Table<0x2::object::ID, EscrowEntry>,
        total_minted: u64,
        total_burned: u64,
    }

    fun assert_operator(arg0: &0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::is_signer(arg0, v0) || 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::is_ops_external(arg0, v0), 3);
    }

    public fun available_count(arg0: &GoldVault, arg1: u8) : u64 {
        if (!0x2::table::contains<u8, vector<0x2::object::ID>>(&arg0.available, arg1)) {
            0
        } else {
            0x1::vector::length<0x2::object::ID>(0x2::table::borrow<u8, vector<0x2::object::ID>>(&arg0.available, arg1))
        }
    }

    public fun burn_redeemed(arg0: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut GoldVault, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_paused(arg0);
        assert_operator(arg0, arg4);
        assert!(0x2::table::contains<0x2::object::ID, EscrowEntry>(&arg1.escrow, arg2), 13);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_blacklisted(arg0, 0x2::table::borrow<0x2::object::ID, EscrowEntry>(&arg1.escrow, arg2).depositor);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::enforce_redeem_limit(arg0, 1, arg3);
        let EscrowEntry {
            nft             : v0,
            depositor       : v1,
            deposited_at_ms : _,
        } = 0x2::table::remove<0x2::object::ID, EscrowEntry>(&mut arg1.escrow, arg2);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::burn(v0);
        arg1.total_burned = arg1.total_burned + 1;
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::burned(arg2, v1);
    }

    public fun deposit_for_redemption(arg0: &0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut GoldVault, arg2: 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_blacklisted(arg0, v0);
        let v1 = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::id(&arg2);
        let v2 = EscrowEntry{
            nft             : arg2,
            depositor       : v0,
            deposited_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<0x2::object::ID, EscrowEntry>(&mut arg1.escrow, v1, v2);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::redemption_deposited(v1, v0);
    }

    public fun execute_distribute(arg0: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut GoldVault, arg2: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::Proposal, arg3: &0x2::clock::Clock) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_paused(arg0);
        let (v0, v1, v2) = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::distribute_params(arg2);
        let v3 = v1;
        let v4 = v0;
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::consume(arg0, arg2, arg3);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_blacklisted(arg0, v2);
        assert!(0x1::vector::length<u8>(&v4) == 0x1::vector::length<u64>(&v3), 15);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v4)) {
            let v6 = *0x1::vector::borrow<u8>(&v4, v5);
            let v7 = 0;
            while (v7 < *0x1::vector::borrow<u64>(&v3, v5)) {
                let v8 = take_one_of_denom(arg1, v6);
                0x2::transfer::public_transfer<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(v8, v2);
                0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::distributed(0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::id(&v8), v2, v6);
                v7 = v7 + 1;
            };
            v5 = v5 + 1;
        };
    }

    public fun execute_mint(arg0: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut GoldVault, arg2: &mut 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::Proposal, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_paused(arg0);
        let (v0, v1, v2, v3) = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::mint_params(arg2);
        let v4 = v0;
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::consume(arg0, arg2, arg3);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::BatchSpec>(&v4)) {
            v5 = v5 + 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::batchspec_qty(0x1::vector::borrow<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::BatchSpec>(&v4, v6));
            v6 = v6 + 1;
        };
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_mint_total(v5);
        let v7 = arg1.total_minted;
        let v8 = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::next_batch(arg0);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::BatchSpec>(&v4)) {
            let v10 = 0x1::vector::borrow<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::BatchSpec>(&v4, v9);
            let v11 = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::batchspec_denom(v10);
            let v12 = 0;
            while (v12 < 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::batchspec_qty(v10)) {
                let v13 = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::mint(v3, v8, 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::next_seq(arg0, v11), v11, v1, v2, 0x2::clock::timestamp_ms(arg3), arg4);
                let v14 = 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::id(&v13);
                0x2::object_table::add<0x2::object::ID, 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(&mut arg1.inventory, v14, v13);
                push_available(arg1, v11, v14);
                arg1.total_minted = arg1.total_minted + 1;
                v12 = v12 + 1;
            };
            v9 = v9 + 1;
        };
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::mint_executed(v8, arg1.total_minted - v7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GoldVault{
            id           : 0x2::object::new(arg0),
            inventory    : 0x2::object_table::new<0x2::object::ID, 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(arg0),
            available    : 0x2::table::new<u8, vector<0x2::object::ID>>(arg0),
            escrow       : 0x2::table::new<0x2::object::ID, EscrowEntry>(arg0),
            total_minted : 0,
            total_burned : 0,
        };
        0x2::transfer::share_object<GoldVault>(v0);
    }

    public fun inventory_count(arg0: &GoldVault) : u64 {
        0x2::object_table::length<0x2::object::ID, 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(&arg0.inventory)
    }

    fun pop_available(arg0: &mut GoldVault, arg1: u8) : 0x2::object::ID {
        assert!(0x2::table::contains<u8, vector<0x2::object::ID>>(&arg0.available, arg1), 18);
        let v0 = 0x2::table::borrow_mut<u8, vector<0x2::object::ID>>(&mut arg0.available, arg1);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(v0), 18);
        0x1::vector::pop_back<0x2::object::ID>(v0)
    }

    fun push_available(arg0: &mut GoldVault, arg1: u8, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<u8, vector<0x2::object::ID>>(&arg0.available, arg1)) {
            0x2::table::add<u8, vector<0x2::object::ID>>(&mut arg0.available, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<u8, vector<0x2::object::ID>>(&mut arg0.available, arg1), arg2);
    }

    public fun reclaim_escrow(arg0: &0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut GoldVault, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        assert!(0x2::table::contains<0x2::object::ID, EscrowEntry>(&arg1.escrow, arg2), 13);
        let v0 = 0x2::tx_context::sender(arg4);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_blacklisted(arg0, v0);
        let v1 = 0x2::table::borrow<0x2::object::ID, EscrowEntry>(&arg1.escrow, arg2);
        assert!(v1.depositor == v0, 22);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.deposited_at_ms + 604800000, 23);
        let EscrowEntry {
            nft             : v2,
            depositor       : v3,
            deposited_at_ms : _,
        } = 0x2::table::remove<0x2::object::ID, EscrowEntry>(&mut arg1.escrow, arg2);
        0x2::transfer::public_transfer<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(v2, v3);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::redemption_returned(arg2, v3);
    }

    public fun return_escrow(arg0: &0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::GovernanceConfig, arg1: &mut GoldVault, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_version(arg0);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_paused(arg0);
        assert_operator(arg0, arg3);
        assert!(0x2::table::contains<0x2::object::ID, EscrowEntry>(&arg1.escrow, arg2), 13);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::governance::assert_not_blacklisted(arg0, 0x2::table::borrow<0x2::object::ID, EscrowEntry>(&arg1.escrow, arg2).depositor);
        let EscrowEntry {
            nft             : v0,
            depositor       : v1,
            deposited_at_ms : _,
        } = 0x2::table::remove<0x2::object::ID, EscrowEntry>(&mut arg1.escrow, arg2);
        0x2::transfer::public_transfer<0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(v0, v1);
        0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::events::redemption_returned(arg2, v1);
    }

    public(friend) fun take_one_of_denom(arg0: &mut GoldVault, arg1: u8) : 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT {
        let v0 = pop_available(arg0, arg1);
        0x2::object_table::remove<0x2::object::ID, 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft::GoldNFT>(&mut arg0.inventory, v0)
    }

    public fun total_burned(arg0: &GoldVault) : u64 {
        arg0.total_burned
    }

    public fun total_minted(arg0: &GoldVault) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v7
}

