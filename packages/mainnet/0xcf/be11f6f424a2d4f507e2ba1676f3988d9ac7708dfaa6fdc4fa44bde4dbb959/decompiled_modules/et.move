module 0xcfbe11f6f424a2d4f507e2ba1676f3988d9ac7708dfaa6fdc4fa44bde4dbb959::et {
    struct ET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ET>(arg0, 6, b"ET", b"Everything", b"Everything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_23_33_01_eb5bbd04df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ET>>(v1);
    }

    // decompiled from Move bytecode v6
}

