module 0x9fe150d5d65badbd5741a8e766a33f80d139dd461b919230c042d9c7c7303c26::smj {
    struct SMJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMJ>(arg0, 6, b"SMJ", b"SuiMoji", b"colors of life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_20_40_37_ec1090b20b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

