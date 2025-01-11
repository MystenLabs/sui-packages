module 0x19a3492b1fe3c4a0574ab73f959db665358cf33784edd638d571fad7d74047dd::nfa {
    struct NFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFA>(arg0, 6, b"NFA", b"Not Financial Advice", b"Dont buy this token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3075_110b14887b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

