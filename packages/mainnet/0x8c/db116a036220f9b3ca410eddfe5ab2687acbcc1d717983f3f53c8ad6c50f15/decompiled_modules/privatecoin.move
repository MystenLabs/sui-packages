module 0x8cdb116a036220f9b3ca410eddfe5ab2687acbcc1d717983f3f53c8ad6c50f15::privatecoin {
    struct PRIVATECOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: 0x2::coin::Coin<PRIVATECOIN>) {
        0x2::coin::burn<PRIVATECOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIVATECOIN>>(0x2::coin::mint<PRIVATECOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIVATECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIVATECOIN>(arg0, 9, b"USDC ", b"Tatr USD", b"yulezhuanyong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmegTguLKv9FgfzPaX6NRYAwGUCY3WHuh8McvPaDEV1NZQ")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIVATECOIN>>(v1);
        let v3 = &mut v2;
        mint(v3, 15901312000000000, @0x5672f994828a21b547dca20934fbd9d141b97e846f7b9bf322867312b6d965ff, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIVATECOIN>>(v2, @0x5672f994828a21b547dca20934fbd9d141b97e846f7b9bf322867312b6d965ff);
    }

    // decompiled from Move bytecode v6
}

