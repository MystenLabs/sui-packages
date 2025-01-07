module 0xb7f0893ba4231e77e7352c755c9c38854a593103a697a775b0092248ad7388e7::tbs {
    struct TBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBS>(arg0, 6, b"TBS", b"Turbass", b"A seabass with a turbo representing Turbos on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731102760070.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

