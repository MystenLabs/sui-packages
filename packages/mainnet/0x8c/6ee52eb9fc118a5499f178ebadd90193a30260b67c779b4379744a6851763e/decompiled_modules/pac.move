module 0x8c6ee52eb9fc118a5499f178ebadd90193a30260b67c779b4379744a6851763e::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"PACMOON", b"Pacmoon is a long-term project that prioritizes planning well and prioritizing community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240929_104225_c4816e20a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

