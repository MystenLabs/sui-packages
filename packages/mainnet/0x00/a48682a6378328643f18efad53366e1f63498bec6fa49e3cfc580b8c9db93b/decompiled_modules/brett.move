module 0xa48682a6378328643f18efad53366e1f63498bec6fa49e3cfc580b8c9db93b::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"Brett on Sui", b"Brett is the legendary character from Matt Furies Boys' club comic. He is a dancer and loves video games. Now he is living on the SUI blockchain as a Fan tribute. After first making a name for himself on SUI, he is now branching out to the other blue blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_620ef8ee67.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

