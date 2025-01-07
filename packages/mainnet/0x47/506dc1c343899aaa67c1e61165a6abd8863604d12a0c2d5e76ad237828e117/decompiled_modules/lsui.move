module 0x47506dc1c343899aaa67c1e61165a6abd8863604d12a0c2d5e76ad237828e117::lsui {
    struct LSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSUI>(arg0, 6, b"LSUI", b"LAPRAS SUI", b"Let's make dream come true with #LSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hand_mocup_ec7b590dd3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

