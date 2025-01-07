module 0xbb8f6b4eabfcf9a55fed081a7e3353765cd6aa673cf7a3765b7fa3e6a4ae8ed3::pmpkin {
    struct PMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMPKIN>(arg0, 6, b"PMPKIN", b"PUMP-KIN", b"Pump The KIN. (Get it? because like PUMP-KIN. Like PUMP-KIN. PUMP. PUMPKIN. PUMP THE KIN ) LETS GO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_07_064712_f552bb741c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

