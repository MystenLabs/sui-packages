module 0x933eebd89fe438a809f1625f21bea14e67de9c64dd595717743eb12247e1e2d5::suitel696969 {
    struct SUITEL696969 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEL696969, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEL696969>(arg0, 6, b"SUITEL696969", b"SuiantelKorei6669i69", x"3639204d4d4d4d4d4d4d4d4d4d206b656b652c206170204936392d34323030303030585858204370454545457520746f6f20362c363647687a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_d0d972198f_acbbcd09e0_cf52432b27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEL696969>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEL696969>>(v1);
    }

    // decompiled from Move bytecode v6
}

