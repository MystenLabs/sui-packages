module 0xd51e443459d374da64a7304d501e3121a0ddcd1d3bac69702793695b9e60a289::BelenLuoFaucetCoin {
    struct BELENLUOFAUCETCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BELENLUOFAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BELENLUOFAUCETCOIN>>(0x2::coin::mint<BELENLUOFAUCETCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BELENLUOFAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELENLUOFAUCETCOIN>(arg0, 1, b"BLF", b"Belen-Luo-Faucet", b"This is the Coin that Belen created in order to learn move", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELENLUOFAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BELENLUOFAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

