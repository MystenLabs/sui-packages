module 0x92fdd69766a7289abc2d11e4e937a7d89f469b538094316966645ed9b7a185ad::yihe {
    struct YIHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIHE>(arg0, 6, b"YIHE", b"Yi He on Sui", b"Co-Founder & Chief customer Service Officer Binance on Sui MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748130079355.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YIHE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIHE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

