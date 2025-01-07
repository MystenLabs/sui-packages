module 0x34300153c19891a9de5f55d5c9c6913688403ad3d815988f3a1af29ba3290f1a::alex {
    struct ALEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALEX>(arg0, 6, b"ALEX", b"ALEX THE PARROT", x"4a6f696e206f75722073706163657320200a46696e64206f757420636f6f6c20616e64206578636974696e67206e6577732061626f757420416c65782074686520506172726f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gi_YCEZ_St_400x400_d199d4297a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

