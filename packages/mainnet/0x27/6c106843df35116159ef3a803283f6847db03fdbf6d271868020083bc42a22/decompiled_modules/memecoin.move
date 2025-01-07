module 0x276c106843df35116159ef3a803283f6847db03fdbf6d271868020083bc42a22::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMECOIN>, arg1: 0x2::coin::Coin<MEMECOIN>) {
        0x2::coin::burn<MEMECOIN>(arg0, arg1);
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECOIN>(arg0, 9, b"MEMECOIN", b"MEMECOIN", b"A Example Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v1);
        0x2::coin::mint_and_transfer<MEMECOIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEMECOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

