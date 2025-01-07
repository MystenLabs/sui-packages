module 0xc500c65f4451cce940b4867c0c952b99bfc3647c878ac9006ba1135c81cc257f::suian696969 {
    struct SUIAN696969 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAN696969, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAN696969>(arg0, 6, b"SUIAN696969", b"SuiantelCorei69", x"3639204d206b654b4b4b4b4b6b652c20416f732049656e206170204936392d3432303030305858582043706565464646467520746f6f20362c363647687a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_d0d972198f_4220633f46.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAN696969>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAN696969>>(v1);
    }

    // decompiled from Move bytecode v6
}

