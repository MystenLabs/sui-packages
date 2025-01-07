module 0x53d1de6a417ae12b262265c51033870de6834d5301740a7918191eb56b988aff::happybird {
    struct HAPPYBIRD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAPPYBIRD>, arg1: 0x2::coin::Coin<HAPPYBIRD>) {
        0x2::coin::burn<HAPPYBIRD>(arg0, arg1);
    }

    fun init(arg0: HAPPYBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAPPYBIRD>(arg0, 6, b"HAPPYBIRD", b"Happy Bird", b"Happy Happy Happy~ Happy Happy Happy Happy~ This is the happy song~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://f4.bcbits.com/img/a4226911043_10.jpg"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAPPYBIRD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAPPYBIRD>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAPPYBIRD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HAPPYBIRD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

