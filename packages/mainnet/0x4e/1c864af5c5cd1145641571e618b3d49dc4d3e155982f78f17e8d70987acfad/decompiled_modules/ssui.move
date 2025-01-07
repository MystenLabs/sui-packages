module 0x4e1c864af5c5cd1145641571e618b3d49dc4d3e155982f78f17e8d70987acfad::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 9, b"SSUI", b"SpringSui", b"A new liquid staking standard for Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1823145570812469249/XvRuizEL_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSUI>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

