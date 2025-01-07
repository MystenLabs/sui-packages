module 0x4d9a296112617d6a6b3a510f4aa0d1c691ef44e2f0c6776a3fceee10695d4071::suisei {
    struct SUISEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEI>(arg0, 6, b"SuiSei", b"Hoshimachi Suisei", b"Introducing Suisei Token, inspired by the dazzling Holo performer herself! Just like Suiseis captivating shows, this token brings a burst of energy and creativity to the SuiChain ecosystem. Join a vibrant community of fans and supporters as we celebrate music, gaming, and innovation. Lets shine together and make waves in the crypto universe! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISEI_LOGO_33e2101d92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

