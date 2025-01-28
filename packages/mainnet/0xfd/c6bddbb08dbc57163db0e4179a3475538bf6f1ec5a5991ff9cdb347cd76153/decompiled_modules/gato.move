module 0xfdc6bddbb08dbc57163db0e4179a3475538bf6f1ec5a5991ff9cdb347cd76153::gato {
    struct GATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATO>(arg0, 6, b"GATO", b"Gato Ai", b"Join the revolution today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030673_226078eb05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

