module 0x54a5fe0b5c57173c478ea0a4ca6fb8bc78d29e978030bf8064589b81281942a::HARAN {
    struct HARAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HARAN>, arg1: 0x2::coin::Coin<HARAN>) {
        0x2::coin::burn<HARAN>(arg0, arg1);
    }

    fun init(arg0: HARAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARAN>(arg0, 2, b"HARAN", b"HARAN", b"HARAN on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0xc961da88bb5e8ee2ba7dfd4c62a875ef80f7202f.jpg?1684025779684")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HARAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HARAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

