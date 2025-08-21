module 0x316dcfc16f6a93ca2bf9d2fefade603744e8414fd581e729f69376c83eda682c::Holy_Ghost {
    struct HOLY_GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLY_GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLY_GHOST>(arg0, 9, b"HOLY", b"Holy Ghost", b"the holy ghost is here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1956417478818476032/E8njOEyK_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLY_GHOST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY_GHOST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

