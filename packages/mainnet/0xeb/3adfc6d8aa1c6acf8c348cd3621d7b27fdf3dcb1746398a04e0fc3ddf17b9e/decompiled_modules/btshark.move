module 0xeb3adfc6d8aa1c6acf8c348cd3621d7b27fdf3dcb1746398a04e0fc3ddf17b9e::btshark {
    struct BTSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTSHARK>(arg0, 6, b"BTSHARK", b"bouncing titty shark", b"stop being a whiny pussy and fucking bounce it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/234234_33d4ab9673.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

