module 0xf315c8cde895cb953cc0cb8b02f7401ebf407a05a39c17f78d7af63d7569b71a::pudgy {
    struct PUDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGY>(arg0, 6, b"PUDGY", b"Pudgy Pengu", b"PENGU On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752585162364.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUDGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

