module 0x758e8f92a825179a2c32eefd12b51366b473f32b0a6d13fc68cad4172079f661::lazy_heartbeat {
    struct NFT has key {
        id: 0x2::object::UID,
        base_age_seconds: u64,
        base_mood: u8,
        base_form: u8,
        mutation_seed: u64,
        last_sync_ms: u64,
        evolution_stage: u8,
    }

    struct SyncEvent has copy, drop {
        nft_id: 0x2::object::ID,
        sync_ms: u64,
        age_seconds: u64,
        mood: u8,
        form: u8,
        stage: u8,
        seed: u64,
    }

    public fun current_age_seconds(arg0: &NFT, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.last_sync_ms == 0 || v0 <= arg0.last_sync_ms) {
            arg0.base_age_seconds
        } else {
            arg0.base_age_seconds + (v0 - arg0.last_sync_ms) / 1000
        }
    }

    public fun current_evolution_stage(arg0: &NFT, arg1: &0x2::clock::Clock) : u8 {
        let v0 = current_age_seconds(arg0, arg1);
        if (v0 < 3600) {
            0
        } else if (v0 < 86400) {
            1
        } else if (v0 < 604800) {
            2
        } else {
            3
        }
    }

    public fun current_form(arg0: &NFT, arg1: &0x2::clock::Clock) : u8 {
        let v0 = arg0.mutation_seed ^ current_age_seconds(arg0, arg1) / 7;
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        *0x1::vector::borrow<u8>(&v2, 1) % 16
    }

    public fun current_mood(arg0: &NFT, arg1: &0x2::clock::Clock) : u8 {
        let v0 = arg0.mutation_seed ^ current_age_seconds(arg0, arg1);
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        *0x1::vector::borrow<u8>(&v2, 0) % 100
    }

    public fun current_traits(arg0: &NFT, arg1: &0x2::clock::Clock) : (u64, u8, u8, u8) {
        (current_age_seconds(arg0, arg1), current_mood(arg0, arg1), current_form(arg0, arg1), current_evolution_stage(arg0, arg1))
    }

    public entry fun mint_1of1(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id               : 0x2::object::new(arg1),
            base_age_seconds : 0,
            base_mood        : 0,
            base_form        : 0,
            mutation_seed    : arg0,
            last_sync_ms     : 0,
            evolution_stage  : 0,
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun sync(arg0: &mut NFT, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.base_age_seconds = current_age_seconds(arg0, arg1);
        arg0.base_mood = current_mood(arg0, arg1);
        arg0.base_form = current_form(arg0, arg1);
        arg0.evolution_stage = current_evolution_stage(arg0, arg1);
        arg0.last_sync_ms = v0;
        let v1 = 0x2::random::new_generator(arg2, arg3);
        if (0x2::random::generate_u8_in_range(&mut v1, 0, 99) == 0) {
            arg0.mutation_seed = 0x2::random::generate_u64(&mut v1);
        };
        let v2 = SyncEvent{
            nft_id      : 0x2::object::id<NFT>(arg0),
            sync_ms     : v0,
            age_seconds : arg0.base_age_seconds,
            mood        : arg0.base_mood,
            form        : arg0.base_form,
            stage       : arg0.evolution_stage,
            seed        : arg0.mutation_seed,
        };
        0x2::event::emit<SyncEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

