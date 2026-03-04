module 0xd64d39273c9fd03333d947c5f21d317e62752d3f833207604d858d20b657a170::lazy_heartbeat {
    struct LAZY_HEARTBEAT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        base_age_seconds: u64,
        base_mood: u8,
        base_form: u8,
        mutation_seed: u64,
        last_sync_ms: u64,
        evolution_stage: u8,
        image_url: 0x1::string::String,
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

    fun build_svg(arg0: u64, arg1: u8, arg2: u8, arg3: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 400 400'%3E");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3Crect width='400' height='400' fill='"));
        0x1::string::append(&mut v0, 0x1::string::utf8(stage_bg(arg3)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"'/%3E"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3Ccircle cx='200' cy='188' r='75' fill='"));
        0x1::string::append(&mut v0, 0x1::string::utf8(heart_fill(arg1)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' opacity='0.15'/%3E"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3Cpath d='M200,162 C200,130 168,110 146,132 C124,152 124,176 146,198 L200,252 L254,198 C276,176 276,152 254,132 C232,110 200,130 200,162Z' fill='"));
        0x1::string::append(&mut v0, 0x1::string::utf8(heart_fill(arg1)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"'/%3E"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3Ctext x='200' y='294' text-anchor='middle' fill='white' font-family='monospace' font-size='22' font-weight='bold'%3E"));
        0x1::string::append(&mut v0, 0x1::string::utf8(stage_name(arg3)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3C/text%3E"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3Ctext x='200' y='324' text-anchor='middle' fill='rgb(180,180,220)' font-family='monospace' font-size='14'%3EMood "));
        0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_bytes((arg1 as u64))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" | Form "));
        0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_bytes((arg2 as u64))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3C/text%3E"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3Ctext x='200' y='352' text-anchor='middle' fill='rgb(100,100,150)' font-family='monospace' font-size='12'%3EAge "));
        0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_bytes(arg0)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"s%3C/text%3E"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3C/svg%3E"));
        v0
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

    fun heart_fill(arg0: u8) : vector<u8> {
        if (arg0 < 25) {
            b"rgb(255,60,60)"
        } else if (arg0 < 50) {
            b"rgb(255,130,0)"
        } else if (arg0 < 75) {
            b"rgb(80,200,120)"
        } else {
            b"rgb(60,140,255)"
        }
    }

    fun init(arg0: LAZY_HEARTBEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LAZY_HEARTBEAT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Lazy Heartbeat"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"41206c6976696e6720312f31204e4654206f6e205375692e205472616974732065766f6c76652066726f6d206f6e2d636861696e2074696d6520e28094206e6f207472616e73616374696f6e73206e65656465642e"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
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
            image_url        : build_svg(0, 0, 0, 0),
        };
        0x2::transfer::public_transfer<NFT>(v0, 0x2::tx_context::sender(arg1));
    }

    fun stage_bg(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"rgb(10,10,20)"
        } else if (arg0 == 1) {
            b"rgb(8,20,42)"
        } else if (arg0 == 2) {
            b"rgb(18,8,48)"
        } else {
            b"rgb(48,5,28)"
        }
    }

    fun stage_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"Newborn"
        } else if (arg0 == 1) {
            b"Awakening"
        } else if (arg0 == 2) {
            b"Growing"
        } else {
            b"Ancient"
        }
    }

    public entry fun sync(arg0: &mut NFT, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = current_age_seconds(arg0, arg1);
        let v2 = current_mood(arg0, arg1);
        let v3 = current_form(arg0, arg1);
        let v4 = current_evolution_stage(arg0, arg1);
        arg0.base_age_seconds = v1;
        arg0.base_mood = v2;
        arg0.base_form = v3;
        arg0.evolution_stage = v4;
        arg0.last_sync_ms = v0;
        arg0.image_url = build_svg(v1, v2, v3, v4);
        let v5 = 0x2::random::new_generator(arg2, arg3);
        if (0x2::random::generate_u8_in_range(&mut v5, 0, 99) == 0) {
            arg0.mutation_seed = 0x2::random::generate_u64(&mut v5);
        };
        let v6 = SyncEvent{
            nft_id      : 0x2::object::id<NFT>(arg0),
            sync_ms     : v0,
            age_seconds : arg0.base_age_seconds,
            mood        : arg0.base_mood,
            form        : arg0.base_form,
            stage       : arg0.evolution_stage,
            seed        : arg0.mutation_seed,
        };
        0x2::event::emit<SyncEvent>(v6);
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

