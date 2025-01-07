module 0x39f6ae793484c1b884001a7eb8e3bfc77841ef0650f8dc17ac55d6b559e22327::adm {
    struct ADM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADM>(arg0, 9, b"ADM", b"Admin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADM>>(v1);
    }

    // decompiled from Move bytecode v6
}

