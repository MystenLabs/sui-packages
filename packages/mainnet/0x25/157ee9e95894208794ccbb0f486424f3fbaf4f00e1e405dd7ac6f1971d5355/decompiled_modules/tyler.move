module 0x25157ee9e95894208794ccbb0f486424f3fbaf4f00e1e405dd7ac6f1971d5355::tyler {
    struct TYLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYLER>(arg0, 6, b"TYLER", b"TylerSui", b"It's all about community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735457965258.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYLER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYLER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

