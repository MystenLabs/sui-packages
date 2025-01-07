module 0xf5ab15e67a7f395e049b169f56bebb138899ddcb1246b1feeb538bae3d4982da::suiville {
    struct SUIVILLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVILLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVILLE>(arg0, 6, b"SUIVILLE", b"SuiVille", b"SuiVille is the chillest village on SUI, with it's deep lake boarder noone can harm the villagers, visit SuiVille and maybe buy some property here, its the perfect place to settle down with your family!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_76e6577e00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVILLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVILLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

