module 0x1ec0cf5113ee71630b9a85c7fba434e216ab5b2aacd12390185edc0984dc926b::cdu {
    struct CDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDU>(arg0, 6, b"CDU", b"capucation", b"Let the capy teach us the way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731246050523.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

