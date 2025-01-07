module 0x976a065c1136e7147ab63e37b1bfdff5850b0159e2c330ac813f21d351186d9b::dizzy {
    struct DIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIZZY>(arg0, 6, b"Dizzy", b"Dizzy On Sui", b"Meet DIZZY, Gekko's fearless armadillo now live on the Sui blockchain! Built on strength and adaptability, this token revolutionizes DeFi and NFTs with unstoppable energy. Join DIZZY as he leads the charge into the future of the Sui ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7338_3008b1721e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

