module 0x8509f32b5788e69e5a344a1b9d7837c8c7844314174625673d78699cffd74320::kwng {
    struct KWNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWNG>(arg0, 6, b"KWNG", b"KWNG TOKEN", b"WHAA! kwng question! Born out of Trenches with a punchline and a purpose, KWNGs got the grit of a daredevil and the vibe of a misfit. Think he's just another token? kwng again. join me, what can go kwng?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_design_b0293cdcb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

