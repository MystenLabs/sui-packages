module 0x6d6f4793915c3f3d7a14591e16f8c1c1b5d2efcbf4f64f83554b3023178421c0::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BPEPE>, arg1: 0x2::coin::Coin<BPEPE>) {
        0x2::coin::burn<BPEPE>(arg0, arg1);
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BPEPE>(arg0, 0, b"BPEPE", b"Bored Pepe", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nftstorage.link/ipfs/bafkreicrhktu365lhha5p74dcd455kagkouyyiogquieu4d4xwez3uljou")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPEPE>>(v2);
        let v4 = &mut v3;
        mint(v4, 21000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v3, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<BPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

