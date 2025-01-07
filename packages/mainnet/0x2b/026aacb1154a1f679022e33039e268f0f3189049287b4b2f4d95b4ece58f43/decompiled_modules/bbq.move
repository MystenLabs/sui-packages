module 0x2b026aacb1154a1f679022e33039e268f0f3189049287b4b2f4d95b4ece58f43::bbq {
    struct BBQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBQ>(arg0, 6, b"BBQ", b"BBQcoinsui", b"BBQcoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003444_7e80ec3dbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

