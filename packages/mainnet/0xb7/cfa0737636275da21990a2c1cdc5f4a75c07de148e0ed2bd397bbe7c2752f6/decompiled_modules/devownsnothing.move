module 0xb7cfa0737636275da21990a2c1cdc5f4a75c07de148e0ed2bd397bbe7c2752f6::devownsnothing {
    struct DEVOWNSNOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVOWNSNOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVOWNSNOTHING>(arg0, 6, b"Devownsnothing", b"devownsnothing", b"nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nothing_logo_63d79ebc14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVOWNSNOTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVOWNSNOTHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

