module 0xb9a629dfdf4866c1ccc788bea6618da8c48b2855261fa7545e8e8e6e435570c1::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKE>(arg0, 9, b"SMOKE", b"Smoking Chicken Dog", b"Moon? Smoke?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMOKE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

