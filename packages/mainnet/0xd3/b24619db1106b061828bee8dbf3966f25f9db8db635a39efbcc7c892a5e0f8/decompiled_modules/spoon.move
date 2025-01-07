module 0xd3b24619db1106b061828bee8dbf3966f25f9db8db635a39efbcc7c892a5e0f8::spoon {
    struct SPOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOON>(arg0, 6, b"SPOON", b"MOON THE POON", b"FIRST MOON THE POON. Official link https://suimoonthepoon.fun https://x.com/MoonthePool_Sui https://t.me/PoolOnSui_Portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_3_e7017a4737.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

