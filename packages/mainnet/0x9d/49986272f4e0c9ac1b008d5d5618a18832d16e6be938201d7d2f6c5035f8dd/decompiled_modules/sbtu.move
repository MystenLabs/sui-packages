module 0x9d49986272f4e0c9ac1b008d5d5618a18832d16e6be938201d7d2f6c5035f8dd::sbtu {
    struct SBTU has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SBTU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SBTU>(arg0) + arg1 <= 11290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SBTU>>(0x2::coin::mint<SBTU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SBTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBTU>(arg0, 6, b"SBTU", b"SBTU", b"SBTU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SBTU>>(0x2::coin::mint<SBTU>(&mut v2, 111290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBTU>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBTU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

