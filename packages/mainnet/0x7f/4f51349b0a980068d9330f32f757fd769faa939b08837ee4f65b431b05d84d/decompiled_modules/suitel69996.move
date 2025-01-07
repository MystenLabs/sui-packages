module 0x7f4f51349b0a980068d9330f32f757fd769faa939b08837ee4f65b431b05d84d::suitel69996 {
    struct SUITEL69996 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEL69996, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEL69996>(arg0, 6, b"SUITEL69996", b"SuiantelKorei69i69", x"3639204d4d4d4d4d4d4d4d4d4d206b656b652c206170204936392d34323030303030585858204370454545457520746f6f20362c363647687a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_d0d972198f_acbbcd09e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEL69996>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEL69996>>(v1);
    }

    // decompiled from Move bytecode v6
}

