module 0x8d2ee4023ac84f464b1f87ff9bce3963f8227211bb7fc4f93ebdbf386004e4d3::lazy_heartbeat {
    struct LAZY_HEARTBEAT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        price: u64,
        enabled: bool,
        treasury: address,
        total_minted: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        base_age_seconds: u64,
        base_mood: u8,
        base_form: u8,
        mutation_seed: u64,
        last_sync_ms: u64,
        evolution_stage: u8,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        price_paid: u64,
        total_minted: u64,
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

    public fun current_traits(arg0: &NFT, arg1: &0x2::clock::Clock) : (u64, u8, u8, u8, u8, u64) {
        (current_age_seconds(arg0, arg1), current_mood(arg0, arg1), current_form(arg0, arg1), evolution_level(arg0, arg1), species(arg0), mutation_flags(arg0, arg1))
    }

    public fun evolution_level(arg0: &NFT, arg1: &0x2::clock::Clock) : u8 {
        let v0 = current_age_seconds(arg0, arg1);
        if (v0 < 60) {
            0
        } else if (v0 < 600) {
            1
        } else if (v0 < 3600) {
            2
        } else if (v0 < 43200) {
            3
        } else if (v0 < 86400) {
            4
        } else {
            5
        }
    }

    public fun get_config(arg0: &MintConfig) : (u64, bool, address, u64) {
        (arg0.price, arg0.enabled, arg0.treasury, arg0.total_minted)
    }

    fun init(arg0: LAZY_HEARTBEAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LAZY_HEARTBEAT>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MintConfig{
            id           : 0x2::object::new(arg1),
            price        : 1000000000,
            enabled      : false,
            treasury     : 0x2::tx_context::sender(arg1),
            total_minted : 0,
        };
        0x2::transfer::share_object<MintConfig>(v1);
    }

    public entry fun mint(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.price, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        arg0.total_minted = arg0.total_minted + 1;
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = NFT{
            id               : 0x2::object::new(arg4),
            base_age_seconds : 0,
            base_mood        : 0x2::random::generate_u8_in_range(&mut v0, 0, 99),
            base_form        : 0x2::random::generate_u8_in_range(&mut v0, 0, 15),
            mutation_seed    : 0x2::random::generate_u64(&mut v0),
            last_sync_ms     : 0x2::clock::timestamp_ms(arg2),
            evolution_stage  : 0,
        };
        let v2 = MintEvent{
            nft_id       : 0x2::object::id<NFT>(&v1),
            minter       : 0x2::tx_context::sender(arg4),
            price_paid   : arg0.price,
            total_minted : arg0.total_minted,
        };
        0x2::event::emit<MintEvent>(v2);
        0x2::transfer::public_transfer<NFT>(v1, 0x2::tx_context::sender(arg4));
    }

    public fun mutation_flags(arg0: &NFT, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.mutation_seed ^ current_age_seconds(arg0, arg1) / 30;
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        (*0x1::vector::borrow<u8>(&v2, 2) as u64) << 8 | (*0x1::vector::borrow<u8>(&v2, 3) as u64)
    }

    public entry fun set_enabled(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.enabled = arg2;
    }

    public entry fun set_price(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.price = arg2;
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    public entry fun setup_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::string::append(&mut arg1, 0x1::string::utf8(b"{id}.svg"));
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lazy Heartbeat"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"48656172746265617420e28692204261627920e2869220437265617475726520e28692204865726f20e28692204d797468696320e2869220436f736d69632e2041206c6976696e67204e4654206f6e205375692e"));
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://lazyheartbeat.xyz"));
        let v4 = 0x2::display::new_with_fields<NFT>(arg0, v0, v2, arg2);
        0x2::display::update_version<NFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v4, 0x2::tx_context::sender(arg2));
    }

    public fun species(arg0: &NFT) : u8 {
        (arg0.mutation_seed as u8) % 4
    }

    public entry fun sync(arg0: &mut NFT, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.base_age_seconds = current_age_seconds(arg0, arg1);
        arg0.base_mood = current_mood(arg0, arg1);
        arg0.base_form = current_form(arg0, arg1);
        arg0.evolution_stage = evolution_level(arg0, arg1);
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

