module 0xf2d4e9decd127edb493ab181414f74300727b7a57b82a8726e027e9e004decd1::lig {
    struct LIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIG>(arg0, 6, b"LIG", b"Ligma", b"Spreading Ligma on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P80_Pv_Ow_U_400x400_1b7b2d96f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

