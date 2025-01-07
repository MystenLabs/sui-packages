module 0x151dba4d816fb2c502d8b9fa331b7786f0399626a70f2176e6f5e2c42d161b30::sturbo {
    struct STURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: STURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STURBO>(arg0, 6, b"STurbo", b"SuiTurbo", b"$Sturbo the fastest #Sui meme coin only on Turbo.Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730440084999.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

