module 0xe9371501d07c46ae8ee3e3dedf540fe0eead8eec79bd03616699ea98ce1efe20::ceem {
    struct CEEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEEM>(arg0, 6, b"Ceem", b"Ceem ", b"Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732566437014.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CEEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEEM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

