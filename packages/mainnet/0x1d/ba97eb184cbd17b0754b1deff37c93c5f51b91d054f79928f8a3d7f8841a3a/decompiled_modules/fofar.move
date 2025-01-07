module 0x1dba97eb184cbd17b0754b1deff37c93c5f51b91d054f79928f8a3d7f8841a3a::fofar {
    struct FOFAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOFAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOFAR>(arg0, 6, b"FOFAR", b"Fofar Gaming", b"The FirSt meme gaming platform on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_16_b0ef3cc0a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOFAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOFAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

