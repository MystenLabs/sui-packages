module 0x16f02cf6b619137dee6ebc5260f30e162c9649e2ea956ed7156c6477409be771::ujeet {
    struct UJEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: UJEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UJEET>(arg0, 6, b"UJEET", b"Ultimate jeeter", b"Unstoppable jeeting. Hate jeeters. Love holders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016172_f7f12f808f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UJEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UJEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

