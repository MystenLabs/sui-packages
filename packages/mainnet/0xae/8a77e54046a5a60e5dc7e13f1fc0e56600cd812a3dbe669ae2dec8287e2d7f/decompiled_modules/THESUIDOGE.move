module 0xae8a77e54046a5a60e5dc7e13f1fc0e56600cd812a3dbe669ae2dec8287e2d7f::THESUIDOGE {
    struct THESUIDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THESUIDOGE>, arg1: 0x2::coin::Coin<THESUIDOGE>) {
        0x2::coin::burn<THESUIDOGE>(arg0, arg1);
    }

    fun init(arg0: THESUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THESUIDOGE>(arg0, 6, b"SUIDOGE", b"The Sui Doge", b"Twitter: @THESUIDOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1654397131065810945/8bO0RmE4_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THESUIDOGE>>(v1);
        0x2::coin::mint_and_transfer<THESUIDOGE>(&mut v2, 550000000000000, 0x2::address::from_u256(58454181676832651002995437026903612124529456210016632369742661304833019219144), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THESUIDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THESUIDOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<THESUIDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

