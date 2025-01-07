module 0x7c15f62ffdaf8db17d0cc1197ef8208417fe4d291043281c6e93e704b468e8b3::suibmarine {
    struct SUIBMARINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBMARINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBMARINE>(arg0, 8, b"SUIBMARINE", b"Suibmarine", b"GEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBjqTaP7wncRfrV_EtO9HPlkAraY5TTBXCVA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBMARINE>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBMARINE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBMARINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

