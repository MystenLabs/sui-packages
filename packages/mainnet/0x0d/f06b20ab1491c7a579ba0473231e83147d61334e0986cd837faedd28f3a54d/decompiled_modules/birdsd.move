module 0xdf06b20ab1491c7a579ba0473231e83147d61334e0986cd837faedd28f3a54d::birdsd {
    struct BIRDSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDSD>(arg0, 6, b"BirdsD", b"Birds", b"The leading Memecoin & GameFi Telegram mini-app on the @SuiNetwork birdx2_bot/bir", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731259180130.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

