module 0x1bcce3da96fc06b46fadc2c08fbd2ca238b46505991a2bf8f0d3cfb0e911a720::suifwog {
    struct SUIFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFWOG>(arg0, 6, b"SuiFWOG", b"Sui FWOGs", b"meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_S1h_GL_0i_400x400_6ca7053275.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

