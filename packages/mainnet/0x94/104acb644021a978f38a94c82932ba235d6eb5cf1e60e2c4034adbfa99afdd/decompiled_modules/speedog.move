module 0x94104acb644021a978f38a94c82932ba235d6eb5cf1e60e2c4034adbfa99afdd::speedog {
    struct SPEEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEEDOG>(arg0, 6, b"SPEEDOG", b"SpeedogSUI", b"Hi, I'm Speedog, people call me the fastest dog on the planet, and I agree. My home is on the Sui blockchain. t.me/SpeedogSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3r_Oj0_ED_2_400x400_0f9686182c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

