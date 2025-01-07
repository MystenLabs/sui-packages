module 0xd8ffea0eb7a2cc5d3b6c61b3b7c45b421b92528e0a3f9bf5882460e1d92264c::vibelaunch {
    struct VIBELAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBELAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBELAUNCH>(arg0, 6, b"VibeLaunch", b"Vibe", b"$Vibe stealth launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K_Ruf2_Yxm_400x400_589267c7f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBELAUNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBELAUNCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

