module 0x6a8a4f25e0a25ab2eedbe82beac394c6d60c7a458f08834be22e490b9550b216::NUTZ {
    struct NUTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTZ>(arg0, 2, b"NUTZ", b"NUTZ IS THE BEST", b"Can you suck my $NUTZ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/gjX39TsD/mushroom-logo-creative-mushroom-logo-icon-design-template-vector.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUTZ>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUTZ>(&mut v2, 10000000, @0xa2772a9338c3109de3dfe29c48bf9e5a64f78e3516346e098e1dd3d3146d8737, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTZ>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

