module 0xb5aab608ed6050e31f9b382da7b09a49363c528a632bb8bc0d59544da96f691::wbtn {
    struct WBTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WBTN>(arg0, 6, b"WBTN", b"Wolv Bitcoinner by SuiAI", x"50726f6a65746f20717565206d69737475726120626f6d2068756d6f72206120706c616e6f7320646520696e6f7661c3a7c3a36f2e204d61697320696e666f726d61c3a7c3b5657320656d2062726576652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Wolv_Biticoinner_34ce86cb8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WBTN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

