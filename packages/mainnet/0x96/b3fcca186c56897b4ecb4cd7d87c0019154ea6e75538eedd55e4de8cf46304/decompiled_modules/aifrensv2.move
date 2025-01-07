module 0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::aifrensv2 {
    struct AifrensPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        has_paused: bool,
        launched_at_ms: u64,
        expired_at_ms: u64,
        init_claim: u64,
        max_addresses: u64,
        is_fair_claim: bool,
        claimed: 0x2::table::Table<address, u64>,
        claimed_supply: u64,
        root_proof: vector<u8>,
        airdrop_balance: 0x2::balance::Balance<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>,
    }

    struct GovPool has store, key {
        id: 0x2::object::UID,
        ref_balance: 0x2::balance::Balance<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>,
    }

    struct BetaPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        has_paused: bool,
        launched_at_ms: u64,
        expired_at_ms: u64,
        init_claim: u64,
        claimed: 0x2::table::Table<0x2::object::ID, u64>,
        claimed_supply: u64,
        airdrop_balance: 0x2::balance::Balance<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>,
    }

    public fun withdraw_beta_pool(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut BetaPool, arg2: u64) : 0x2::balance::Balance<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS> {
        0x2::balance::split<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(&mut arg1.airdrop_balance, arg2)
    }

    public fun withdraw_suifrens_pool(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut AifrensPool, arg2: u64) : 0x2::balance::Balance<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS> {
        0x2::balance::split<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(&mut arg1.airdrop_balance, arg2)
    }

    public entry fun beta_claim(arg0: &mut BetaPool, arg1: &0x2::clock::Clock, arg2: &0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.has_paused, 4);
        assert!(v0 > arg0.launched_at_ms, 5);
        assert!(v0 < arg0.expired_at_ms, 6);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = can_claim_beta_amount(arg0, arg1, arg2);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.claimed, 0x2::object::id<0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis>(arg2), 1);
        assert!(v2 >= 1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>>(0x2::coin::from_balance<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(0x2::balance::split<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(&mut arg0.airdrop_balance, v2), arg3), v1);
        arg0.claimed_supply = arg0.claimed_supply + v2;
        0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::eventv2::airdrop_event(v1, v2);
        v2
    }

    fun calc_claim_after_4_days(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 + 3 * 86400000 < arg2) {
            0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::mathv2::mul_div(arg0, 95, 100)
        } else {
            arg0
        };
        let v1 = if (arg1 + 4 * 86400000 < arg2) {
            0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::mathv2::mul_div(v0, 94, 100)
        } else {
            v0
        };
        let v2 = if (arg1 + 5 * 86400000 < arg2) {
            0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::mathv2::mul_div(v1, 93, 100)
        } else {
            v1
        };
        if (arg1 + 6 * 86400000 < arg2) {
            0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::mathv2::mul_div(v2, 92, 100)
        } else {
            v2
        }
    }

    public fun can_claim_amount(arg0: &AifrensPool, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        assert!(!0x2::table::contains<address, u64>(&arg0.claimed, arg2), 2);
        let v0 = 0x2::table::length<address, u64>(&arg0.claimed);
        if (v0 >= arg0.max_addresses) {
            0
        } else if (arg0.is_fair_claim) {
            arg0.init_claim
        } else {
            let v2 = arg0.init_claim;
            let v3 = 5 * 1000000000000;
            while (v3 < 0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::mathv2::mul_div(v0 + 1, 100 * 1000000000000, arg0.max_addresses)) {
                let v4 = v2 * 80;
                v2 = v4 / 100;
                v3 = v3 + 5 * 1000000000000;
            };
            get_actual_claim(arg0, arg1, v2)
        }
    }

    public fun can_claim_beta_amount(arg0: &BetaPool, arg1: &0x2::clock::Clock, arg2: &0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis) : u64 {
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg0.claimed, 0x2::object::id<0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis>(arg2)), 2);
        let v0 = 0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::birthdate(arg2);
        let v1 = if (v0 > 1683378000000 + 2 * 86400000) {
            arg0.init_claim
        } else if (v0 > 1683378000000 + 86400000) {
            arg0.init_claim * 4
        } else {
            arg0.init_claim * 5
        };
        calc_claim_after_4_days(v1, arg0.launched_at_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public entry fun claim(arg0: &mut AifrensPool, arg1: &0x2::clock::Clock, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        claim_internal(arg0, arg1, arg2, arg3)
    }

    fun claim_internal(arg0: &mut AifrensPool, arg1: &0x2::clock::Clock, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.has_paused, 4);
        assert!(v0 > arg0.launched_at_ms, 5);
        assert!(v0 < arg0.expired_at_ms, 6);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::merkle_treev2::verify_calldata(arg2, arg0.root_proof, 0x1::bcs::to_bytes<address>(&v1)), 3);
        let v2 = can_claim_amount(arg0, arg1, v1);
        0x2::table::add<address, u64>(&mut arg0.claimed, v1, 1);
        assert!(v2 >= 1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>>(0x2::coin::from_balance<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(0x2::balance::split<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(&mut arg0.airdrop_balance, v2), arg3), v1);
        arg0.claimed_supply = arg0.claimed_supply + v2;
        0x96b3fcca186c56897b4ecb4cd7d87c0019154ea6e75538eedd55e4de8cf46304::eventv2::airdrop_event(v1, v2);
        v2
    }

    fun get_actual_claim(arg0: &AifrensPool, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        calc_claim_after_4_days(arg2, arg0.launched_at_ms, 0x2::clock::timestamp_ms(arg1))
    }

    fun is_emergency(arg0: &AifrensPool) : bool {
        arg0.has_paused
    }

    public fun pause(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut AifrensPool) {
        arg1.has_paused = true;
    }

    public fun resume(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut AifrensPool) {
        arg1.has_paused = false;
    }

    public entry fun set_proof_root(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut AifrensPool, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.root_proof = arg2;
    }

    public fun transfer_beta_pool(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut 0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::BetaPool, arg2: &mut BetaPool, arg3: u64) {
        0x2::balance::join<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(&mut arg2.airdrop_balance, 0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::withdraw_beta_pool(arg0, arg1, arg3));
        let v0 = 0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::get_beta_claimed(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg2.claimed, *0x1::vector::borrow<0x2::object::ID>(&v0, v1), 1);
        };
    }

    public fun transfer_suifrens_pool(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut 0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AifrensPool, arg2: &mut AifrensPool, arg3: u64) {
        0x2::balance::join<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(&mut arg2.airdrop_balance, 0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::withdraw_suifrens_pool(arg0, arg1, arg3));
        let v0 = 0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::get_suifrens_claimed(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            0x2::table::add<address, u64>(&mut arg2.claimed, *0x1::vector::borrow<address>(&v0, v1), 1);
        };
    }

    public entry fun update_time(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut AifrensPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.launched_at_ms = arg2;
        arg1.expired_at_ms = arg3;
    }

    public fun withdraw_ref_pool(arg0: &0x2::coin::TreasuryCap<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>, arg1: &mut GovPool, arg2: u64) : 0x2::balance::Balance<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS> {
        0x2::balance::split<0x361fcb86803eea2403007250638f3c8427249168ac77fee74b7129bdc05b2586::aifrens::AIFRENS>(&mut arg1.ref_balance, arg2)
    }

    // decompiled from Move bytecode v6
}

