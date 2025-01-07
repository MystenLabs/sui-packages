module 0x700bc461a1770e88484fba639f214222fae34bce5b35dc3af00f560c3a2683a6::tunneljew {
    struct TUNNELJEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNNELJEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNNELJEW>(arg0, 6, b"TunnelJew", b"Jew in tunnel", b"jew tunnel in new york", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_10_065933857_55441e8c0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNNELJEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNNELJEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

