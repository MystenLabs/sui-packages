module 0x78557d435d6703b9f53f0bb7c186aeb644e31df3944b12392a6930bc115536f::sottersui {
    struct SOTTERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTTERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTTERSUI>(arg0, 6, b"SOTTERSUI", b"SOTTER", x"546865206d6173636f74206f662053756920636861696e2e0a24534f5454455253554920686173206e6f206465762e2049742069732074686520636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_015737254_f2761c553b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTTERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOTTERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

