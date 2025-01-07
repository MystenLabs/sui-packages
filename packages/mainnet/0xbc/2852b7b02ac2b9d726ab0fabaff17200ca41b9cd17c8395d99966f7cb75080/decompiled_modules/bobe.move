module 0xbc2852b7b02ac2b9d726ab0fabaff17200ca41b9cd17c8395d99966f7cb75080::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"Bobe on sui", b"The nanny is taking Bobe and the unicorn for a morning walk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039262_06482d9972.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

