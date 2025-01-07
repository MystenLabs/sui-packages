module 0x2e4f7e33f2181cf1c28547387b9235ddfdf8b08b1544fabcd878afd7e2601579::crox {
    struct CROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROX>(arg0, 9, b"CROX", b"CROX", x"f09f92a72443524f58206c6f766573206368696c6c696e672077697468206869732062726f7320245045504520616e642024504f4e4b452c2062757420617420736f6d6520706f696e74207468657927726520646f6f6d656420746f206265636f6d6520686973206e657874206d65616c2e202054656c656772616d3a2068747470733a2f2f742e6d652f63726f785f7375692020547769747465723a2068747470733a2f2f782e636f6d2f63726f785f7375692020576562736974653a2068747470733a2f2f63726f787375692e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/croxsui/crox/refs/heads/main/image_2024-10-15_02-33-00.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CROX>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROX>>(v1);
    }

    // decompiled from Move bytecode v6
}

