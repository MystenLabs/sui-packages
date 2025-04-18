module 0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends {
    struct AIFRENS_FOOTIE_LEGENDS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AifrensGenesis has store, key {
        id: 0x2::object::UID,
        generation: u64,
        birthdate: u64,
        genes: vector<u8>,
        birth_location: 0x1::string::String,
    }

    struct AifrensGenesisGlobal has store, key {
        id: 0x2::object::UID,
        price: u64,
        cap: u64,
        count: u64,
        beneficary: address,
        start_time_ms: u64,
        expired_time_ms: u64,
        paused: bool,
    }

    struct MintEvent has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        generation: u64,
        genes: vector<u8>,
        birth_location: 0x1::string::String,
    }

    fun get_random(arg0: &0x2::clock::Clock, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg2));
        0x2::hash::keccak256(&v1)
    }

    fun init(arg0: AIFRENS_FOOTIE_LEGENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AIFRENS Footie Legends"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://explorer.sui.io/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://api.suifrens.ai/nft/aifrens-footie-legends.png?id={id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AIFRENS Footie Legends NFT is a limited edition digital collectible that grants holders access to exclusive rewards and benefits within the AIFRENS ecosystem, including eligibility for airdrops, access to AIFRENS Fi protocols, AIFRENS GameFi verse, AIFRENS private communities and Legend Fusion to unlock unique abilities."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suifrens.ai/"));
        let v5 = 0x2::package::claim<AIFRENS_FOOTIE_LEGENDS>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<AifrensGenesis>(&v5, v1, v3, arg1);
        0x2::display::update_version<AifrensGenesis>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<AifrensGenesis>>(v6, v0);
        let v7 = AifrensGenesisGlobal{
            id              : 0x2::object::new(arg1),
            price           : 2000000000,
            cap             : 50000,
            count           : 0,
            beneficary      : @0x8cea53d2e3754e03baa54622fea23dad1806f3c3da78b2a440737e1b9ec8e793,
            start_time_ms   : 1683377400000,
            expired_time_ms : 1683982800000,
            paused          : false,
        };
        0x2::transfer::share_object<AifrensGenesisGlobal>(v7);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v8, v0);
    }

    public entry fun mint(arg0: &mut AifrensGenesisGlobal, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > arg0.start_time_ms, 1);
        assert!(v0 < arg0.expired_time_ms, 2);
        assert!(arg0.count < arg0.cap, 4);
        arg0.count = arg0.count + 1;
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.price, arg4), arg0.beneficary);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        let v2 = get_random(arg1, v1, arg0.count);
        let v3 = AifrensGenesis{
            id             : 0x2::object::new(arg4),
            generation     : 0,
            birthdate      : v0,
            genes          : v2,
            birth_location : 0x1::string::utf8(arg3),
        };
        let v4 = MintEvent{
            id             : 0x2::object::uid_to_inner(&v3.id),
            creator        : v1,
            generation     : 0,
            genes          : v2,
            birth_location : 0x1::string::utf8(arg3),
        };
        0x2::event::emit<MintEvent>(v4);
        0x2::transfer::transfer<AifrensGenesis>(v3, v1);
    }

    public entry fun update_conf(arg0: &mut AifrensGenesisGlobal, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: &AdminCap, arg7: &mut 0x2::tx_context::TxContext) {
        arg0.price = arg1;
        arg0.start_time_ms = arg2;
        arg0.expired_time_ms = arg3;
        arg0.paused = arg4;
        arg0.cap = arg5;
    }

    // decompiled from Move bytecode v6
}

