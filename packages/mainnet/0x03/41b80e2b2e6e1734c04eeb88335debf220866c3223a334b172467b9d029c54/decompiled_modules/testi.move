module 0x341b80e2b2e6e1734c04eeb88335debf220866c3223a334b172467b9d029c54::testi {
    struct TESTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTI>(arg0, 6, b"TESTI", b"TESTING", b"TESTING. Let's make See how this works. Hope this ends up being a good idea. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738342876178.59")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

