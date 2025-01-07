module 0x88c06e4b5335c32b48333ee79862378b19fcc4842ae55fec129021ff2414cc47::joeyfaucetcoin {
    struct JOEYFAUCETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOEYFAUCETCOIN>, arg1: 0x2::coin::Coin<JOEYFAUCETCOIN>) {
        0x2::coin::burn<JOEYFAUCETCOIN>(arg0, arg1);
    }

    fun init(arg0: JOEYFAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEYFAUCETCOIN>(arg0, 9, b"JOEYF", b"Joey Faucet Coin", b"itsjoeyrighthere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/48686956")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOEYFAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JOEYFAUCETCOIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOEYFAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOEYFAUCETCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

