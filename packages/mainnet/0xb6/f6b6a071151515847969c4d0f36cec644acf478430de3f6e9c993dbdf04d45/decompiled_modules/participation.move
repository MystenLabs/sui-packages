module 0xb6f6b6a071151515847969c4d0f36cec644acf478430de3f6e9c993dbdf04d45::participation {
    struct Participant has copy, drop, store {
        wallet: address,
        joined_at_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DrawSeedEvent has copy, drop {
        price_satoshis: u64,
        oracle_timestamp_ms: u64,
        block_seed: u64,
        master_seed: u64,
        participant_count: u64,
        winner_count: u64,
        registration_end_ms: u64,
    }

    struct DrawExpansionEvent has copy, drop {
        master_seed: u64,
        lcg_a: u64,
        lcg_c: u64,
        modulus: u64,
        iterations: u64,
        lcg_trace: vector<u64>,
        winner_indices: vector<u64>,
        winners: vector<address>,
    }

    struct Race has key {
        id: 0x2::object::UID,
        admin: address,
        name: 0x1::string::String,
        max_participants: u64,
        winner_count: u64,
        registration_start_ms: u64,
        registration_end_ms: u64,
        finalized: bool,
        participants: 0x2::table::Table<address, Participant>,
        participant_order: vector<address>,
        winners: vector<address>,
        winner_indices: vector<u64>,
        draw_price_satoshis: u64,
        draw_oracle_timestamp_ms: u64,
        draw_block_seed: u64,
        draw_master_seed: u64,
        draw_lcg_a: u64,
        draw_lcg_c: u64,
        draw_modulus: u64,
        draw_iterations: u64,
        draw_executed_at_ms: u64,
        lcg_trace: vector<u64>,
        has_draw_proof: bool,
    }

    public fun create_race(arg0: &AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < arg5, 8);
        let v0 = Race{
            id                       : 0x2::object::new(arg6),
            admin                    : 0x2::tx_context::sender(arg6),
            name                     : arg1,
            max_participants         : arg2,
            winner_count             : arg3,
            registration_start_ms    : arg4,
            registration_end_ms      : arg5,
            finalized                : false,
            participants             : 0x2::table::new<address, Participant>(arg6),
            participant_order        : 0x1::vector::empty<address>(),
            winners                  : 0x1::vector::empty<address>(),
            winner_indices           : 0x1::vector::empty<u64>(),
            draw_price_satoshis      : 0,
            draw_oracle_timestamp_ms : 0,
            draw_block_seed          : 0,
            draw_master_seed         : 0,
            draw_lcg_a               : 0xb6f6b6a071151515847969c4d0f36cec644acf478430de3f6e9c993dbdf04d45::randomness::lcg_a(),
            draw_lcg_c               : 0xb6f6b6a071151515847969c4d0f36cec644acf478430de3f6e9c993dbdf04d45::randomness::lcg_c(),
            draw_modulus             : 0,
            draw_iterations          : 0,
            draw_executed_at_ms      : 0,
            lcg_trace                : 0x1::vector::empty<u64>(),
            has_draw_proof           : false,
        };
        0x2::transfer::share_object<Race>(v0);
    }

    fun derive_internal_block_seed(arg0: &Race, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = *0x2::tx_context::digest(arg3);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0.registration_end_ms));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0.winner_count));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = 0;
        let v3 = 24;
        while (v3 < 32) {
            let v4 = v2 * 256;
            v2 = v4 + (*0x1::vector::borrow<u8>(&v1, v3) as u64);
            v3 = v3 + 1;
        };
        v2
    }

    public fun finalize_winners(arg0: &mut Race, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        assert!(!arg0.finalized, 5);
        let v0 = 0x1::vector::length<address>(&arg0.participant_order);
        assert!(v0 >= arg0.winner_count, 6);
        let (v1, v2) = read_btc_price_from_pyth(arg2, arg1);
        let v3 = derive_internal_block_seed(arg0, v1, v2, arg3);
        let v4 = 0xb6f6b6a071151515847969c4d0f36cec644acf478430de3f6e9c993dbdf04d45::randomness::mix_entropy(v1, v3);
        let (v5, v6, v7) = 0xb6f6b6a071151515847969c4d0f36cec644acf478430de3f6e9c993dbdf04d45::randomness::expand_unique_indices_with_trace(v4, v0, arg0.winner_count, arg3);
        let v8 = v5;
        let v9 = 0x1::vector::empty<address>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&v8)) {
            0x1::vector::push_back<address>(&mut v9, *0x1::vector::borrow<address>(&arg0.participant_order, *0x1::vector::borrow<u64>(&v8, v10)));
            v10 = v10 + 1;
        };
        arg0.winners = v9;
        arg0.winner_indices = v8;
        arg0.lcg_trace = v6;
        arg0.draw_price_satoshis = v1;
        arg0.draw_oracle_timestamp_ms = v2;
        arg0.draw_block_seed = v3;
        arg0.draw_master_seed = v4;
        arg0.draw_modulus = v0;
        arg0.draw_iterations = v7;
        arg0.draw_executed_at_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.has_draw_proof = true;
        arg0.finalized = true;
        let v11 = DrawSeedEvent{
            price_satoshis      : v1,
            oracle_timestamp_ms : v2,
            block_seed          : v3,
            master_seed         : v4,
            participant_count   : v0,
            winner_count        : arg0.winner_count,
            registration_end_ms : arg0.registration_end_ms,
        };
        0x2::event::emit<DrawSeedEvent>(v11);
        let v12 = DrawExpansionEvent{
            master_seed    : v4,
            lcg_a          : arg0.draw_lcg_a,
            lcg_c          : arg0.draw_lcg_c,
            modulus        : v0,
            iterations     : v7,
            lcg_trace      : v6,
            winner_indices : v8,
            winners        : v9,
        };
        0x2::event::emit<DrawExpansionEvent>(v12);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_finalized(arg0: &Race) : bool {
        arg0.finalized
    }

    public fun is_joined(arg0: &Race, arg1: address) : bool {
        0x2::table::contains<address, Participant>(&arg0.participants, arg1)
    }

    public fun join_race(arg0: &mut Race, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.finalized, 4);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.registration_start_ms && v0 <= arg0.registration_end_ms, 2);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, Participant>(&arg0.participants, v1), 3);
        if (arg0.max_participants > 0) {
            assert!(0x1::vector::length<address>(&arg0.participant_order) < arg0.max_participants, 9);
        };
        let v2 = Participant{
            wallet       : v1,
            joined_at_ms : v0,
        };
        0x2::table::add<address, Participant>(&mut arg0.participants, v1, v2);
        0x1::vector::push_back<address>(&mut arg0.participant_order, v1);
    }

    fun normalize_price_to_8_decimals(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v0), 11);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1);
        let v3 = if (v2) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)
        };
        if (v2) {
            if (v3 >= 8) {
                0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0) / pow10(v3 - 8)
            } else {
                0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0) * pow10(8 - v3)
            }
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0) * pow10(v3 + 8)
        }
    }

    public fun participant_count(arg0: &Race) : u64 {
        0x1::vector::length<address>(&arg0.participant_order)
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun read_btc_price_from_pyth(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == x"e62df6c8b4a85fe1a67db44dc12de5db330f7ac66b72dc658afedf0f4a415b43", 10);
        (normalize_price_to_8_decimals(&v0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000)
    }

    public fun winner_count(arg0: &Race) : u64 {
        0x1::vector::length<address>(&arg0.winners)
    }

    // decompiled from Move bytecode v6
}

