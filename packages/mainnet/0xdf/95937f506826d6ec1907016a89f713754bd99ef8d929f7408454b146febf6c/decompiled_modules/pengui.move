module 0xdf95937f506826d6ec1907016a89f713754bd99ef8d929f7408454b146febf6c::pengui {
    struct PENGUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUI>(arg0, 6, b"PENGUI", b"Pengui", b"The Cleverest Penguin On SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_12_35_44_PM_c7e1b19bf5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

