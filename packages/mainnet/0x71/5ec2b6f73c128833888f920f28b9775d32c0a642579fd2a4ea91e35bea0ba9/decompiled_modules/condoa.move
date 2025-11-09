module 0x715ec2b6f73c128833888f920f28b9775d32c0a642579fd2a4ea91e35bea0ba9::condoa {
    struct CONDOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONDOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONDOA>(arg0, 9, b"CondoA", b"Condo A", b"This is the coin for condo A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imganuncios.mitula.net/condominium_2030001762210475964.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CONDOA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONDOA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONDOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

