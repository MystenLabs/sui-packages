module 0x49170dc5fdd7e094f1129e7930ab9a6575d4a342dcad5ce77e9839285bcf86e9::suikids {
    struct SUIKIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIDS>(arg0, 6, b"SUIKIDS", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKIDS>>(v1);
        0x2::coin::mint_and_transfer<SUIKIDS>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIDS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

