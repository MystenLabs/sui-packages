module 0xf236bbef1cbb158067864e8bb1598cf8efcef4b36cff95594a7de6c4abeab3c5::airdrop_mafiadogs {
    struct MafiaDogAirDrop has store, key {
        id: 0x2::object::UID,
    }

    struct AirdropEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
    }

    struct AIRDROP_MAFIADOGS has drop {
        dummy_field: bool,
    }

    public entry fun airdrop(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MafiaDogAirDrop{id: 0x2::object::new(arg1)};
        let v1 = AirdropEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AirdropEvent>(v1);
        0x2::transfer::public_transfer<MafiaDogAirDrop>(v0, arg0);
    }

    fun init(arg0: AIRDROP_MAFIADOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Mafia Dogs FlipCoin"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.ibb.co/sbW9wz5/Play-now.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bet 1 SUI, win 1 SUI! Flip the coin for fortune and embrace endless possibilities. Play now, let luck lead the way!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Mafia Dogs FlipCoin"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://mafiadog.xyz"));
        let v4 = 0x2::package::claim<AIRDROP_MAFIADOGS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MafiaDogAirDrop>(&v4, v0, v2, arg1);
        0x2::display::update_version<MafiaDogAirDrop>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MafiaDogAirDrop>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

