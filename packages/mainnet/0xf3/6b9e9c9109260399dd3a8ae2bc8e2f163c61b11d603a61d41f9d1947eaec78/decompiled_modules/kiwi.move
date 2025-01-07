module 0xf36b9e9c9109260399dd3a8ae2bc8e2f163c61b11d603a61d41f9d1947eaec78::kiwi {
    struct KIWI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KIWI>, arg1: 0x2::coin::Coin<KIWI>) {
        0x2::coin::burn<KIWI>(arg0, arg1);
    }

    fun init(arg0: KIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIWI>(arg0, 3, b"KIWI", b"KIWI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tickerperry.xyz/kiwi.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIWI>>(v1);
        0x2::coin::mint_and_transfer<KIWI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIWI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KIWI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KIWI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

