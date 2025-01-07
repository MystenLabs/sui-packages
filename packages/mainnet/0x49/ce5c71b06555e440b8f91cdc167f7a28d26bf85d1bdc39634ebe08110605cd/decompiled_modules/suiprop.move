module 0x49ce5c71b06555e440b8f91cdc167f7a28d26bf85d1bdc39634ebe08110605cd::suiprop {
    struct SUIPROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPROP>(arg0, 9, b"SUIFOOL", b"foolish", b"This is a revolutionary coin that will change the way you transact!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://freelogopng.com/images/all_img/1690643640twitter-x-icon-png.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPROP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPROP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIPROP>>(v2);
    }

    // decompiled from Move bytecode v6
}

