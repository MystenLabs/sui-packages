module 0xde917a4e9499a893cb7da9d295ee269a01fed8f1201fd64cb52d7e3671655440::zunso {
    struct ZUNSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUNSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUNSO>(arg0, 6, b"Zunso", b"Zunso Coin", b"ZUNSOOOOOOOOOOOOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734385168608.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUNSO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUNSO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

