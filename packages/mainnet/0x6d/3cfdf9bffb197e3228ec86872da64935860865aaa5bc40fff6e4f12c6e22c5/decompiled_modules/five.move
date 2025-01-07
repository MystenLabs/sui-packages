module 0x6d3cfdf9bffb197e3228ec86872da64935860865aaa5bc40fff6e4f12c6e22c5::five {
    struct FIVE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FIVE>, arg1: 0x2::coin::Coin<FIVE>) {
        0x2::coin::burn<FIVE>(arg0, arg1);
    }

    fun init(arg0: FIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVE>(arg0, 6, b"FIVE", b"FIVESUILP", b"JUST FIVE SUI LP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-00.iconduck.com/assets.00/high-five-icon-256x256-sbtlv39e.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FIVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FIVE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

