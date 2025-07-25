module 0xbd90601e85b1b51f4b47d070423073f7d2da2febecadcd0d0f9046ce1dce045::asdf {
    struct ASDF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASDF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASDF>>(0x2::coin::mint<ASDF>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: ASDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDF>(arg0, 9, b"ASDF", b"sf asdfasdf", b"asdf asdfdsf sdfsdf dsfdsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plz.money/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ASDF>>(0x2::coin::mint<ASDF>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

