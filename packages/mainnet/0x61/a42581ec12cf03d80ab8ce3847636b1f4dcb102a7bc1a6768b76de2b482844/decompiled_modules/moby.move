module 0x61a42581ec12cf03d80ab8ce3847636b1f4dcb102a7bc1a6768b76de2b482844::moby {
    struct MOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 6, b"MOBY", b"Moby-Dick", b"Moby-Dick. The Giant Sperm Whale.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moby_f29fffd0bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

