module 0xf126ea227cb14f671e7c325dcec4e4ba708bc17553bc26917d41a8b704a2a14d::suibeaverr {
    struct SUIBEAVERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEAVERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEAVERR>(arg0, 6, b"SUIBEAVERR", b"SUIBEAVER", x"5468652070726f746563746f72206f6620746865207375692065636f73797374656d2e2024535549424541564552202d207375696265617665720a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/923r9keaka_63f342e11d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEAVERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEAVERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

