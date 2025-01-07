module 0xdc69916eb5f055420b66b21df27b026af51dac9f71d981aabee9314acf3b6c44::edoge {
    struct EDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EDOGE>, arg1: 0x2::coin::Coin<EDOGE>) {
        0x2::coin::burn<EDOGE>(arg0, arg1);
    }

    fun init(arg0: EDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOGE>(arg0, 9, b"EDOGE", b"Ethereum Doge", b"Ethereum Doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU5CzoLw59yApYXNQBRf9CkzJbP7iYxssxZCq62EzqeTM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EDOGE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<EDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

