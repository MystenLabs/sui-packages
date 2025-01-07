module 0x777859b3f8afa7b3034a99dcd437158eef52dc28f0b15acbcc7a93c3ab1e20d::hitler {
    struct HITLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HITLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HITLER>(arg0, 9, b"HITLER", b"HITLER", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://compote.slate.com/images/247864b6-95ca-4e79-8359-a7861f145b28.jpg?crop=250%2C250%2Cx0%2Cy0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HITLER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HITLER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HITLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

