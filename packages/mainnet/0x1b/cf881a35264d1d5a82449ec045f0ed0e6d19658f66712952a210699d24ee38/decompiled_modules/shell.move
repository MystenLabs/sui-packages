module 0x1bcf881a35264d1d5a82449ec045f0ed0e6d19658f66712952a210699d24ee38::shell {
    struct SHELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHELL>(arg0, 6, b"SHELL", b"Shell the sea", b"\"If you want to hear the sound of the distant ocean, put your ear to the lip of a seashell.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055285_ee5e32d63b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

