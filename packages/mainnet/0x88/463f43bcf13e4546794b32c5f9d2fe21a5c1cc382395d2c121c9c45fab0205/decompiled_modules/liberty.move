module 0x88463f43bcf13e4546794b32c5f9d2fe21a5c1cc382395d2c121c9c45fab0205::liberty {
    struct LIBERTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBERTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBERTY>(arg0, 6, b"LIBERTY", b"LIBERTY COIN", x"546865207374617465206f66206265696e6720667265652077697468696e20736f63696574792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_002012_254_16e7d6dbdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBERTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIBERTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

