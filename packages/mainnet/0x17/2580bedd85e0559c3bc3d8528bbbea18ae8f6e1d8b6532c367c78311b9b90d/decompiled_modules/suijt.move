module 0x172580bedd85e0559c3bc3d8528bbbea18ae8f6e1d8b6532c367c78311b9b90d::suijt {
    struct SUIJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJT>(arg0, 6, b"SUIJT", b"Super Unusual Individual, Just Thriving", b"Super Unusual Individual, Just Thriving on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_02_56_51_e122d9da8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

