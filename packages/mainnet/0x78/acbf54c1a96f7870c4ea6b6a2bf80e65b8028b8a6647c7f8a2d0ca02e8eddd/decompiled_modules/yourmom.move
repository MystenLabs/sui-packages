module 0x78acbf54c1a96f7870c4ea6b6a2bf80e65b8028b8a6647c7f8a2d0ca02e8eddd::yourmom {
    struct YOURMOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOURMOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOURMOM>(arg0, 6, b"YOURMOM", b"yourmom.", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b".")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YOURMOM>(&mut v2, 6666666000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOURMOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOURMOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

