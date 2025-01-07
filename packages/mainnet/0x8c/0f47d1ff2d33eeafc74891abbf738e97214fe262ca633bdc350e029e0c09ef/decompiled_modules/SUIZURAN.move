module 0x8c0f47d1ff2d33eeafc74891abbf738e97214fe262ca633bdc350e029e0c09ef::SUIZURAN {
    struct SUIZURAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIZURAN>, arg1: 0x2::coin::Coin<SUIZURAN>) {
        0x2::coin::burn<SUIZURAN>(arg0, arg1);
    }

    fun init(arg0: SUIZURAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZURAN>(arg0, 2, b"SUIZURAN", b"Suizuran", b"Suizuran High School", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZURAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZURAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIZURAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIZURAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

