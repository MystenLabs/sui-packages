module 0xd6a16a2877868fc1fe886759f8e7dbdfe13f28dbd0bb618f6b08c427a6cdfc3f::suigmadoge {
    struct SUIGMADOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGMADOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMADOGE>(arg0, 6, b"SUIGMADOGE", b"Suigma Doge", b"Suigma doge is rizzing his way onto the blockchain, on God, low key brute maxxxing gains and leveling up his aura points no cap. He's on a mewing streak and giving sigma vibes back to Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038618_efc6f32163.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMADOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGMADOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

