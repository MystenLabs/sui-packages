module 0xfac34bc6e63066d9984d31ffc15044ffae23c6516164a9fd984d26434c93118c::hallomeme {
    struct HALLOMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOMEME>(arg0, 6, b"HALLOMEME", b"HALLOMEME on SUI", b"Halloween of our favorites memes...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0i5f_Owb2_400x400_8502680274.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

