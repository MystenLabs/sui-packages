module 0x45f2d3543a6472ce5c6c0bb97497daf9b9cf9bb53ac36adf39fa3a5d3e6af2e0::nole {
    struct NOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLE>(arg0, 6, b"NOLE", b"Nole on Sui", b"Welcome to the adventures of NOLE, where every transaction is a wild ride in Elon Musk's universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nolejr_153cbf101f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

