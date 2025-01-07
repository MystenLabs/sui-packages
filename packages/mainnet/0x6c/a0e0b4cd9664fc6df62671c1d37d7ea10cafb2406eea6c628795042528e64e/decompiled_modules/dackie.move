module 0x6ca0e0b4cd9664fc6df62671c1d37d7ea10cafb2406eea6c628795042528e64e::dackie {
    struct DACKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DACKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DACKIE>(arg0, 6, b"DACKIE", b"Dackie fluoke", b" The most catchy memecoin out there that anyone can win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dackie_47fbd0fdf9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DACKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DACKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

