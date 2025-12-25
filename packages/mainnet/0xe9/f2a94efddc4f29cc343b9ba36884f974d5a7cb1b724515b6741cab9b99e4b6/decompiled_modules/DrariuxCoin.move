module 0xe9f2a94efddc4f29cc343b9ba36884f974d5a7cb1b724515b6741cab9b99e4b6::DrariuxCoin {
    struct DRARIUXCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRARIUXCOIN>, arg1: 0x2::coin::Coin<DRARIUXCOIN>) {
        0x2::coin::burn<DRARIUXCOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRARIUXCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::total_supply<DRARIUXCOIN>(arg0);
        assert!(v0 < 10000000000000000000, 1);
        assert!(arg1 <= 10000000000000000000 - v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DRARIUXCOIN>>(0x2::coin::mint<DRARIUXCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DRARIUXCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRARIUXCOIN>(arg0, 9, b"DRC", b"Drariux Coin", b"DRC: The Drariux Coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmcpc4CtEX6oTmRj3mRSZ4qBFknC1GbLgodFwoF9itiA67")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRARIUXCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRARIUXCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

