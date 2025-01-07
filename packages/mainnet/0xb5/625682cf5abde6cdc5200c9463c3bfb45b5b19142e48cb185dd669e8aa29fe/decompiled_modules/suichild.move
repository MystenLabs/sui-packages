module 0xb5625682cf5abde6cdc5200c9463c3bfb45b5b19142e48cb185dd669e8aa29fe::suichild {
    struct SUICHILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHILD>(arg0, 9, b"SUICHILD", b"suichild", b"Son of suiman and suiwoman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICHILD>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHILD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHILD>>(v1);
    }

    // decompiled from Move bytecode v6
}

