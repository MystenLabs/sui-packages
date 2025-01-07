module 0xcbcd1cca6d5dc52dcd94ce69e1fdef8857a45d5cf1955ade1e98c463b757f652::chady {
    struct CHADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADY>(arg0, 6, b"CHADY", b"Chady", b"Chady is the Chad of SSUI. Hes a degen obsessed with crypto and his hair. From BOMBO team and MAD content creator, here comes a unique and fun character like no other.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727104486541_ea5417cc3842eeef09aa84987708f438_ac5e0e496b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

