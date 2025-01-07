module 0x485cf9f230d108d64f5537b4749c7c19f4964c82789120bf4721c676e395bea4::cheeseball {
    struct CHEESEBALL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHEESEBALL>, arg1: 0x2::coin::Coin<CHEESEBALL>) {
        0x2::coin::burn<CHEESEBALL>(arg0, arg1);
    }

    fun init(arg0: CHEESEBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEESEBALL>(arg0, 9, b"Cheeseball the Wizard", b"CHEESEBALL", b"Cheeseball the wizard cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYqBfSZmGYEV5zirfsdFTNrJWGEidyuFjQMHFj7Aa4R68")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHEESEBALL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEESEBALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEESEBALL>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHEESEBALL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHEESEBALL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

