module 0x9e31472010eab7153fc95c7f3c3736295fa44f836b1476086876c64b1a721d58::the {
    struct THE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE>(arg0, 6, b"The", b"The View", x"492061736b65642047726f6b20746f2067656e657261746520616e20696d616765206f6620546865205669657720f09f9882", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731197065170.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

