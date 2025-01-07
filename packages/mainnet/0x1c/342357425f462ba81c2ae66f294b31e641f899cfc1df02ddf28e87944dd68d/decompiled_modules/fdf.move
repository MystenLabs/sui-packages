module 0x1c342357425f462ba81c2ae66f294b31e641f899cfc1df02ddf28e87944dd68d::fdf {
    struct FDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDF>(arg0, 9, b"fdf", b"dfd", b"fdfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FDF>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

