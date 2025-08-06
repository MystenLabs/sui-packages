module 0x3e4c2f5aa72ab15b0597a1d0eb1e89c15a7f904be0e5e1258f79e6cc2bb131f8::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 9, b"SS", b"Sample Share", b"sssssssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"1111111.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SS>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

