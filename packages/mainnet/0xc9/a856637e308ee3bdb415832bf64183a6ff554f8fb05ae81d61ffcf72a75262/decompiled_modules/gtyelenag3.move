module 0xc9a856637e308ee3bdb415832bf64183a6ff554f8fb05ae81d61ffcf72a75262::gtyelenag3 {
    struct GTYELENAG3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTYELENAG3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTYELENAG3>(arg0, 9, 0x1::string::utf8(b"GTYELENAG3"), 0x1::string::utf8(x"79656c656ec4812e626173652e657468"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Lf1T9pKgidymv3l-jwlfd4EZKGC-g_IXiMpqtztLhp62djWWG-YBeFFfiWV28EqtjEsnD4dFxJ6saLzjND_sStRXNeeRetjWAe0-wXf9A6GVHmHOsOmKGvR2IOhQQwx9PCFOPfbgYdGWNrSWxoexdC7y1GuDUeetE0q67kaz3OQHWm84k6CuBt5sQ5Qxm42dqGnhAFKDfmiBkt523005_054MzFiMA-pWqsGcnzGz9-e8L3FNPAYJvscWBdVQlIZTnYXEdZ3eJOI9VPMl8OTrtG3aIJZOG8Uhhpiu9-J-sTYRHyy8cBStKVys2gto0xHJBxMRWhxH-SfdornduKWIA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTYELENAG3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTYELENAG3>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

