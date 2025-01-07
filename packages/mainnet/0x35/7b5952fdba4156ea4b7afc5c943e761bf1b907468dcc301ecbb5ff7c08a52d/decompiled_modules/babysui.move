module 0x357b5952fdba4156ea4b7afc5c943e761bf1b907468dcc301ecbb5ff7c08a52d::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 9, b"BABYSUI", b"Baby Sui", b"A supplement for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pepecat.org/wp-content/uploads/2024/10/COIN-LOGO.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSUI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

