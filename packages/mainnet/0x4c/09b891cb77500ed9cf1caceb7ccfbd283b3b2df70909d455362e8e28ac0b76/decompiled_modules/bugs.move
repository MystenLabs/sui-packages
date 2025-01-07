module 0x4c09b891cb77500ed9cf1caceb7ccfbd283b3b2df70909d455362e8e28ac0b76::bugs {
    struct BUGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGS>(arg0, 6, b"BUGS", b"Bugs Inside", b"oh no, again?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_14_T212157_439_a12fba1358.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

