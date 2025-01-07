module 0x811305a24e28edb4f791b688a027f5775566b47a235274aadaf2f25d885d40bc::joeycoin {
    struct JOEYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOEYCOIN>, arg1: 0x2::coin::Coin<JOEYCOIN>) {
        0x2::coin::burn<JOEYCOIN>(arg0, arg1);
    }

    fun init(arg0: JOEYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEYCOIN>(arg0, 9, b"JOEY", b"Joey Coin", b"itsjoeyrighthere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/48686956")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOEYCOIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOEYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOEYCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

