module 0xaedddc74ab80235f159be6696b07a5424459649b52ee835625d1a59e59cc3eca::must {
    struct MUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUST>(arg0, 6, b"MUST", b"Mustache", b"MUSTACHE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C4583922_D91_D_425_C_8_BFD_5068521_BB_5_AE_4d77befa26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

