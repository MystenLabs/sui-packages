module 0x542b92bd2882a168146c0d116dd120c27766768dc8c0424cfaf4e5bf2f3f794c::less {
    struct LESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LESS>(arg0, 6, b"LESS", b"HOPELESS", b"TURBOS BETTER THAN HOPELESS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951124606.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

