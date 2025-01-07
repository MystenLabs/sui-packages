module 0xbaac2228de5305176480ea43aa60bcfea7dd4cfd2883f2ead2211869ba94bb5a::dizzy {
    struct DIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIZZY>(arg0, 6, b"DIZZY", b"DIZZY ON SUI", b"Meet DIZZY, Gekko's fearless armadillo now live on the Sui blockchain! Built on strength and adaptability, this token revolutionizes DeFi and NFTs with unstoppable energy. Join DIZZY as he leads the charge into the future of the Sui ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_12_09_41_29_8cc1f0a414.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

