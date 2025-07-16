module 0x52de52ecae7b0c2757f62b8eb7ab0553c57b157b94a15cdf1631797388875b17::down {
    struct DOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWN>(arg0, 6, b"DOWN", b"Asian Kid Down", b"Are you $DOWN for up only?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752660430069.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

