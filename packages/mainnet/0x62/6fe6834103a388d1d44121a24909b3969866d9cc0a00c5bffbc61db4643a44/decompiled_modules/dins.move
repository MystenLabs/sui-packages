module 0x626fe6834103a388d1d44121a24909b3969866d9cc0a00c5bffbc61db4643a44::dins {
    struct DINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINS>(arg0, 6, b"DINS", b"Dev is NOT Sleeping", b"I'm just testing some stuff, enjoy apes. No dev funds, I'm poor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ftu8_G_1_WYAE_7_Y_Ak_859eef48a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

