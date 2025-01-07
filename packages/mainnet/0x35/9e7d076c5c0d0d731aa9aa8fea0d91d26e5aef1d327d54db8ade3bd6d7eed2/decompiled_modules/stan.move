module 0x359e7d076c5c0d0d731aa9aa8fea0d91d26e5aef1d327d54db8ade3bd6d7eed2::stan {
    struct STAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAN>(arg0, 6, b"STAN", b"STAN THE SWORDFISH", b"Protector of the sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sword_d34336b768.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

