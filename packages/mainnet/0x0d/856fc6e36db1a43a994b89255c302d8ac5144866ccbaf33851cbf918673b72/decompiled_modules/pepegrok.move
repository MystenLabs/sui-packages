module 0xd856fc6e36db1a43a994b89255c302d8ac5144866ccbaf33851cbf918673b72::pepegrok {
    struct PEPEGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEGROK>(arg0, 6, b"PEPEGROK", b"The Pepe Grok", x"5065706547726f6b20207468652041492d706f776572656420646567656e20776974682061206d696e64206f6620697473206f776e2e20536d61727465722c2066756e6e6965722c20616e6420616c77617973206f6e6520737465702061686561642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepegrok_logo_3ecbfd7e1d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEGROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEGROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

