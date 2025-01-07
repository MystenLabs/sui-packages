module 0x5d4556e4ad7a26baf09e38f74f65aeaff0a04578baf33092dc026fffafe3e004::shell {
    struct SHELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHELL>(arg0, 6, b"SHELL", b"Shell of sea", b"\"If you want to hear the sound of the distant ocean, put your ear to the lip of a seashell.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055281_8f7baa3a17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

