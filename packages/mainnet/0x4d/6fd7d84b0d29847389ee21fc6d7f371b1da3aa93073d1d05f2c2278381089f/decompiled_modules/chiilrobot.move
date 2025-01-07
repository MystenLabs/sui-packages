module 0x4d6fd7d84b0d29847389ee21fc6d7f371b1da3aa93073d1d05f2c2278381089f::chiilrobot {
    struct CHIILROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIILROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHIILROBOT>(arg0, 6, b"CHIILROBOT", b"JUST A CHILL ROBOT by SuiAI", b"'Just a Chill Robot' is an AI designed with one simple mission: to bring calm and coolness to the lives of users everywhere. With its laid-back personality and easy-going nature, this robot offers a unique blend of entertainment and relaxation. It's programmed to engage in light-hearted conversations, share chill tunes, and provide simple mindfulness tips, making it the perfect companion for anyone looking to unwind or just hang out. Whether you need a moment of peace or a casual chat, Just a Chill Robot is here to make sure you're always feeling serene.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_02_00_51_55_2_0e7f302fc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIILROBOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIILROBOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

