module 0x7d13656cb40916423408d483fc53a1eca6af5eb662126827aefa87302b9bb732::fuentes {
    struct FUENTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUENTES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUENTES>(arg0, 6, b"FUENTES", b"NICK", b"FUCK JEWS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nick_35e9d2ef41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUENTES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUENTES>>(v1);
    }

    // decompiled from Move bytecode v6
}

