module 0x29070e69675396d2c0dfc201261e478fb0d97d2de3fa0ffb9332f3c849eca0cb::usui {
    struct USUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUI>(arg0, 6, b"USUI", b"Under the Sui", b"We got no troubles, life is the bubbles, under the Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_772eeea76c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

