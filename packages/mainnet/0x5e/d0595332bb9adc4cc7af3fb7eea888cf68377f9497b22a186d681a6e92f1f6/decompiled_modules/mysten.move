module 0x5ed0595332bb9adc4cc7af3fb7eea888cf68377f9497b22a186d681a6e92f1f6::mysten {
    struct MYSTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTEN>(arg0, 6, b"MYSTEN", b"Team Mysten ", b"PREPARE FOR UPTIME AND MAKE IT DOUBLE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747058953069.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYSTEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

