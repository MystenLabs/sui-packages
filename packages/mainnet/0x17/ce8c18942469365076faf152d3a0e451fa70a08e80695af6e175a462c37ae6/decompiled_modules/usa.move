module 0x17ce8c18942469365076faf152d3a0e451fa70a08e80695af6e175a462c37ae6::usa {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 6, b"USA", b"Trump USA", b"USA on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737229740799.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

