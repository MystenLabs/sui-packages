module 0x9f85750b2bcf64f2649c546a3d1f1b9dadde45dce84ba78c1de9356c15336af2::tkz {
    struct TKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKZ>(arg0, 6, b"TKZ", b"Tonkatsu", b"Tonkatsu Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tonkatsu2_4c56e8df79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

