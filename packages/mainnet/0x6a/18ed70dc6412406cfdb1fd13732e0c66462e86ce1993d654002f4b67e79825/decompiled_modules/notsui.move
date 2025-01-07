module 0x6a18ed70dc6412406cfdb1fd13732e0c66462e86ce1993d654002f4b67e79825::notsui {
    struct NOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTSUI>(arg0, 9, b"NOTSUI", b"Not Sui", b"It is not Sui coin, it is mem coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/404/826/large/daniel-moudatsos-close.jpg?1727466335")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOTSUI>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

