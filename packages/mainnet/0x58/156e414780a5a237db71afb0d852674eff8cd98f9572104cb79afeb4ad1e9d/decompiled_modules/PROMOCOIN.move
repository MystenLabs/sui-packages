module 0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::PROMOCOIN {
    struct PROMOCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PROMOCOIN>, arg1: 0x2::coin::Coin<PROMOCOIN>) {
        0x2::coin::burn<PROMOCOIN>(arg0, arg1);
    }

    fun init(arg0: PROMOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROMOCOIN>(arg0, 9, b"SUI available to transfer from testnet to mainnet ", b"Transfer SUI from testnet to mainnet, Visit suinet.xyz", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets-currency.kucoin.com/644b3314022eae0001db3110_coin-logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROMOCOIN>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROMOCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PROMOCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PROMOCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

