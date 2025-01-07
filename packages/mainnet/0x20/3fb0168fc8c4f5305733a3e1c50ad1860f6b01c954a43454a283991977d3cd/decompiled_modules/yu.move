module 0x203fb0168fc8c4f5305733a3e1c50ad1860f6b01c954a43454a283991977d3cd::yu {
    struct YU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YU>(arg0, 9, b"yu", b"tyu", b"y", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YU>>(v1);
    }

    // decompiled from Move bytecode v6
}

