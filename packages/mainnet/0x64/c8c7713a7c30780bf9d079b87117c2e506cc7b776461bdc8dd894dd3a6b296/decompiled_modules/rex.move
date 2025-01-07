module 0x64c8c7713a7c30780bf9d079b87117c2e506cc7b776461bdc8dd894dd3a6b296::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"Rex", b"suirex | $REX", x"49e280996d205265782c207765e28099726520616c6c20526578e280a62e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955802934.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

