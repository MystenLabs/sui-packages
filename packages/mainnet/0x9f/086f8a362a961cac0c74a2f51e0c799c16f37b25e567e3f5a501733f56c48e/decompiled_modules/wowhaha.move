module 0x9f086f8a362a961cac0c74a2f51e0c799c16f37b25e567e3f5a501733f56c48e::wowhaha {
    struct WOWHAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWHAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWHAHA>(arg0, 6, b"Wowhaha", b"wow", b"sucez", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731260229049.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWHAHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWHAHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

