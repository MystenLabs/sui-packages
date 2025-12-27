module 0xfdf1e3a6cd3dcdd6ae39c4a243ad1fba04cb2514fb1ec98bdd30d54f20d0a63::sgit {
    struct SGIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/Q1T7815Yuv0dJbOVs3Fpfo1SQZKfs32GMkL2D14ZFCc";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/Q1T7815Yuv0dJbOVs3Fpfo1SQZKfs32GMkL2D14ZFCc"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SGIT>(arg0, 9, trim_right(b"SGIT"), trim_right(b"SGIT  "), trim_right(b"SGITGOTOFAN"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SGIT>>(0x2::coin::mint<SGIT>(&mut v5, 10000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGIT>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SGIT>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGIT>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

