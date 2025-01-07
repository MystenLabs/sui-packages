module 0xac29b288e5a186bf58b954a2a23fdcb1092fa3694147739c2699d9e27b4431f1::smash {
    struct SMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASH>(arg0, 6, b"SMASH", b"Sui Smash Bros", b"Were happy to introduce SUI Smash Bros, the first-ever Web 3 Roblox-style arcade platform built on the SUI network. Our vision is simple yet ambitious: to bring old-school nostalgia into the future of gaming by introducing everyone to SUI through fun, immersive, and classic arcade games.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_Rvmf_Nv_A_400x400_31a29fefa4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

