module 0x66669cde809fd72a7620e079f79e64ac1752cc352d5543027421e795200a25ab::mavrik {
    struct MAVRIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAVRIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAVRIK>(arg0, 6, b"Mavrik", b"Mavriks Sui", b"Mavriks on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_ecr_A_2024_12_04_104022_d15dd00943.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAVRIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAVRIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

