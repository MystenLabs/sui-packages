module 0xaa500c363242db962fefc639d1ec08d1a439eac9e2ba9ed7fd9c6e298b4ab7e7::veithly {
    struct VEITHLY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VEITHLY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VEITHLY>>(0x2::coin::mint<VEITHLY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VEITHLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEITHLY>(arg0, 6, b"VLY", b"veithly", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VEITHLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEITHLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

