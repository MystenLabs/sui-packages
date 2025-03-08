module 0xd10c9f25bd5fc411efb289543ec0596976082d50cfed8e32d888e3137dea0d11::pine {
    struct PINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINE>(arg0, 9, b"PINE", b"Pineapple", b"A sweet and tropical token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

