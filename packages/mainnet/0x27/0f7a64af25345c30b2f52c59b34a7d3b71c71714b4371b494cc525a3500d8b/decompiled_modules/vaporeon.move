module 0x270f7a64af25345c30b2f52c59b34a7d3b71c71714b4371b494cc525a3500d8b::vaporeon {
    struct VaporeonMintEvent has copy, drop {
        id: 0x2::object::ID,
        shiny: bool,
        kiosk_id: 0x2::object::ID,
    }

    struct VaporeonRegistry has store, key {
        id: 0x2::object::UID,
        minted: u64,
    }

    struct Vaporeon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        shiny: 0x1::string::String,
    }

    struct VaporeonKey has store, key {
        id: 0x2::object::UID,
    }

    struct VAPOREON has drop {
        dummy_field: bool,
    }

    public fun from_seed(arg0: vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) >= 8, 9223372401926995967);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u64(&mut v0)
    }

    fun init(arg0: VAPOREON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} {shiny}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.aresrpg.world"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.aresrpg.world/item/vaporeon{shiny}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A commemorative pet for the old VaporeonOnSui community which got deceived by the owner. You can use it on AresRPG"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aresrpg.world"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"VaporeonOnSui"));
        let v4 = 0x2::package::claim<VAPOREON>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Vaporeon>(&v4, v0, v2, arg1);
        0x2::display::update_version<Vaporeon>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Vaporeon>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = VaporeonRegistry{
            id     : 0x2::object::new(arg1),
            minted : 0,
        };
        0x2::transfer::public_share_object<VaporeonRegistry>(v6);
        let v7 = 500;
        while (v7 > 0) {
            v7 = v7 - 1;
            let v8 = VaporeonKey{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<VaporeonKey>(v8, 0x2::tx_context::sender(arg1));
        };
    }

    fun mint(arg0: &mut VaporeonRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<Vaporeon>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < 1000, 9223372625265295359);
        arg0.minted = arg0.minted + 1;
        let v0 = rng_with_clock(0, 100, arg4, arg5);
        let v1 = if (v0 < 5) {
            b"shiny"
        } else {
            b""
        };
        let v2 = Vaporeon{
            id    : 0x2::object::new(arg5),
            name  : 0x1::string::utf8(b"Vaporeon"),
            shiny : 0x1::string::utf8(v1),
        };
        let v3 = v1 == b"shiny";
        let v4 = VaporeonMintEvent{
            id       : 0x2::object::uid_to_inner(&v2.id),
            shiny    : v3,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<VaporeonMintEvent>(v4);
        0x2::kiosk::lock<Vaporeon>(arg1, arg2, arg3, v2);
    }

    public fun mint_with_key(arg0: VaporeonKey, arg1: &mut VaporeonRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Vaporeon>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let VaporeonKey { id: v0 } = arg0;
        0x2::object::delete(v0);
        mint(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun mint_with_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut VaporeonRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Vaporeon>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 60000000000, 9223372754114314239);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8);
        mint(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun raw_seed(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::tx_context::epoch(arg0);
        let v2 = 0x2::object::new(arg0);
        0x2::object::delete(v2);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, 0x2::object::uid_to_bytes(&v2));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        v3
    }

    public fun rng_with_clock(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1 > arg0, 9223372466351505407);
        from_seed(seed_with_clock(arg2, arg3)) % (arg1 - arg0) + arg0
    }

    public fun seed_with_clock(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = raw_seed(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::hash::sha3_256(v0)
    }

    public fun uid(arg0: &mut Vaporeon) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

