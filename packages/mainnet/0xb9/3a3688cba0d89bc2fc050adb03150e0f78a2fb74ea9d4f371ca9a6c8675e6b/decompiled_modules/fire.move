module 0xb93a3688cba0d89bc2fc050adb03150e0f78a2fb74ea9d4f371ca9a6c8675e6b::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE>(arg0, 6, b"FIRE", b"FIREFUN", b"Everything in the world is made of fire. The world is, was and will be an eternal fire, by measures extinguished and by measures rekindled", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_D_D_D_D_N_2580aa4db4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

