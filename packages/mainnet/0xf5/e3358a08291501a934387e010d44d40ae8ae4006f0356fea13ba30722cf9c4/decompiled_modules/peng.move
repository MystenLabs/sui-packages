module 0xf5e3358a08291501a934387e010d44d40ae8ae4006f0356fea13ba30722cf9c4::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"Peng", b"pengus", b"hello im pengus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifrq6nxru7ishbi5qntiiolomy2wwwughfh337gviovugd3h4xtya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

