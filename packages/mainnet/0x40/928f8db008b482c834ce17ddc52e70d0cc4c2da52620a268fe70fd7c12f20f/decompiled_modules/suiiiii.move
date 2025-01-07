module 0x40928f8db008b482c834ce17ddc52e70d0cc4c2da52620a268fe70fd7c12f20f::suiiiii {
    struct SUIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIII>(arg0, 9, b"SUIIIII", b"SUIIIIII", b"https://t.me/SUIIIIIIonSUI   http://x.com/SUIIIIIIonSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIIIII>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIII>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

