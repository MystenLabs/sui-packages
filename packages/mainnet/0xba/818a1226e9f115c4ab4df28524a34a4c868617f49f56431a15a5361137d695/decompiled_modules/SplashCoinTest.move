module 0xba818a1226e9f115c4ab4df28524a34a4c868617f49f56431a15a5361137d695::SplashCoinTest {
    struct SPLASHCOINTEST has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPLASHCOINTEST>, arg1: 0x2::coin::Coin<SPLASHCOINTEST>) {
        0x2::coin::burn<SPLASHCOINTEST>(arg0, arg1);
    }

    fun init(arg0: SPLASHCOINTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASHCOINTEST>(arg0, 2, b"SPLASHTEST", b"SPT", b"This is splash coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLASHCOINTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHCOINTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPLASHCOINTEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPLASHCOINTEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

