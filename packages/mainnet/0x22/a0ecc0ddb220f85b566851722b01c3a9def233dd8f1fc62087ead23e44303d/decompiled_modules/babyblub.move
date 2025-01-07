module 0x22a0ecc0ddb220f85b566851722b01c3a9def233dd8f1fc62087ead23e44303d::babyblub {
    struct BABYBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBLUB>(arg0, 6, b"BabyBlub", b"BabyBlubSui", b"Baby Blub son of a gun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BBAY_BLUB_f4c03e2873.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

