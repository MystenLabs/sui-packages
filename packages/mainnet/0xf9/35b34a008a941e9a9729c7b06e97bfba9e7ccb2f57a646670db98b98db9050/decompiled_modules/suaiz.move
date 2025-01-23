module 0xf935b34a008a941e9a9729c7b06e97bfba9e7ccb2f57a646670db98b98db9050::suaiz {
    struct SUAIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAIZ>(arg0, 1, b"SUAIz", b"SUaI16z", b"SUaI16z is the first AI VC fund, fully managed by Marc AIndreessen with recommendations from members of the DAO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/2573de40-d9a0-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUAIZ>>(v1);
        0x2::coin::mint_and_transfer<SUAIZ>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAIZ>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

