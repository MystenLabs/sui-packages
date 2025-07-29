module 0xf448902af700335ac4e8e24549d18f6ed584d559cb5e13eca2580b56f9f71891::LBJ {
    struct LBJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBJ>(arg0, 6, b"LebronJames", b"LBJ", b"Your basketball Goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LBJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

