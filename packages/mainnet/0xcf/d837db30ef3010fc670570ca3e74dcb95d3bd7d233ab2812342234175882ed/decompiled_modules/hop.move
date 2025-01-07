module 0xcfd837db30ef3010fc670570ca3e74dcb95d3bd7d233ab2812342234175882ed::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", b"HOP.FUN", x"53776170206f6e200a405375694e6574776f726b0a20666f722074686520626573742070726963652077697468207a65726f20666565732e2054473a2068747470733a2f2f74672e686f702e6167", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5006045973222370473_c_45f488acf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

