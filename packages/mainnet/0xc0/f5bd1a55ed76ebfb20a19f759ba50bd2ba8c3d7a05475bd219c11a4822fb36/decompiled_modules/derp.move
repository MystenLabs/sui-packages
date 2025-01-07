module 0xc0f5bd1a55ed76ebfb20a19f759ba50bd2ba8c3d7a05475bd219c11a4822fb36::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 6, b"Derp", b"DerpCoin", b"DerpCoin represents the \"derpy\" side of meme culturethe goofy, I dont know what Im doing, but Im here for it vibe. DerpCoin is the coin for everyone whos just here to have fun, mess around, and embrace the chaos of the meme world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshots_2024_11_02_01_44_01_b032194ed1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

