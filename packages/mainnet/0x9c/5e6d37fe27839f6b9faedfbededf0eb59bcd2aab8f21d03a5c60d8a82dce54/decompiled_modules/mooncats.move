module 0x9c5e6d37fe27839f6b9faedfbededf0eb59bcd2aab8f21d03a5c60d8a82dce54::mooncats {
    struct MOONCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONCATS>(arg0, 6, b"Mooncats", b"mooncats", b"cats go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_16_24_15_aef10efaf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

