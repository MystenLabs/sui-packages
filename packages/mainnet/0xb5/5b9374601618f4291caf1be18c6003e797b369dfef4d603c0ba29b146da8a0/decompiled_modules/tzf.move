module 0xb55b9374601618f4291caf1be18c6003e797b369dfef4d603c0ba29b146da8a0::tzf {
    struct TZF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TZF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TZF>(arg0, 6, b"tzf", b"tzf", b"hjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TZF>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TZF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TZF>>(v1);
    }

    // decompiled from Move bytecode v6
}

