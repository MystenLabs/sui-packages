module 0xfb9a82925705f8688bfba02724c78b3d94cc5cd64227923e4a46654e20a178d::mdk {
    struct MDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDK>(arg0, 6, b"MDK", b"Mudskipper the fish", b"follow me on tiktok and Instagram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002213_820912a330.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

