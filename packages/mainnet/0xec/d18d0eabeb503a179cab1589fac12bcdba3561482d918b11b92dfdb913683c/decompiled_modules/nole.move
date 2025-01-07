module 0xecd18d0eabeb503a179cab1589fac12bcdba3561482d918b11b92dfdb913683c::nole {
    struct NOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLE>(arg0, 6, b"NOLE", b"NOLE on Sui", b"NOLE is the first reversed ELON on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nolejr_e99e58a507.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

