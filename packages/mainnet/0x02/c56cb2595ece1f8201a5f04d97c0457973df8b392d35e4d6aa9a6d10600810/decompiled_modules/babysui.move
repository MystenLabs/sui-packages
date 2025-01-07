module 0x2c56cb2595ece1f8201a5f04d97c0457973df8b392d35e4d6aa9a6d10600810::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 9, b"BABYSUI", b"Baby Sui", b"A supplement for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pepecat.org/wp-content/uploads/2024/10/COIN-LOGO.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSUI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(v2, @0xbcb13ba183d4e60aa86320b059908b9414ba7f442d932d2462c4cf382248e732);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

