module 0x3155e54edcd3fbda8fc850285d1a4f34bf4029a5492baea0929702383e6235dd::xtok {
    struct XTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: XTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTOK>(arg0, 9, b"XTOK", b"Xtok", b"Elon Musk plans on buying TikTok.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQzM1T97hLi9iULTvivfpa4steCPvkL9QPTY95FafiU25")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XTOK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XTOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTOK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

