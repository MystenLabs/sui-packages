module 0xbd78643c4823f87ff15eceec08c205291506fa22b87eabd0bbfe0343ba87f7::work {
    struct WORK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WORK>, arg1: 0x2::coin::Coin<WORK>) {
        0x2::coin::burn<WORK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WORK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WORK>>(0x2::coin::mint<WORK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORK>(arg0, 9, b"WORK", b"WORK", b"HELLO WORLD!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

