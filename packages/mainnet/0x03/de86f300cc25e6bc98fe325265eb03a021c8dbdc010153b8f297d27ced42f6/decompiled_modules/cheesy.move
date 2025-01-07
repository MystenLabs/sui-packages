module 0x3de86f300cc25e6bc98fe325265eb03a021c8dbdc010153b8f297d27ced42f6::cheesy {
    struct CHEESY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEESY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEESY>(arg0, 9, b"CHEESY", b"Suiss Cheese", b"Take a bite of Suiss Cheese.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHEESY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEESY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEESY>>(v1);
    }

    // decompiled from Move bytecode v6
}

