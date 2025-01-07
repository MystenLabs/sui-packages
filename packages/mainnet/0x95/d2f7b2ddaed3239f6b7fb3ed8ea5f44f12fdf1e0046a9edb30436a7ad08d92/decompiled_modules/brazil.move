module 0x95d2f7b2ddaed3239f6b7fb3ed8ea5f44f12fdf1e0046a9edb30436a7ad08d92::brazil {
    struct BRAZIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAZIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAZIL>(arg0, 9, b"brazil", b"brazil", b"brazill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRAZIL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAZIL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAZIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

