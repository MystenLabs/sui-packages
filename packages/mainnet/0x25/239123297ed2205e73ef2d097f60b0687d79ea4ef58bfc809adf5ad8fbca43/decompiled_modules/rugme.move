module 0x25239123297ed2205e73ef2d097f60b0687d79ea4ef58bfc809adf5ad8fbca43::rugme {
    struct RUGME has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGME>(arg0, 6, b"RUGME", b"Rug Me Sui", b"Come talk shit about serial ruggers and probably get rugged again. I need shitty mods and admins that could rug me and others at any moment.  This is a must prerequisite!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22_b3ab2843b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGME>>(v1);
    }

    // decompiled from Move bytecode v6
}

