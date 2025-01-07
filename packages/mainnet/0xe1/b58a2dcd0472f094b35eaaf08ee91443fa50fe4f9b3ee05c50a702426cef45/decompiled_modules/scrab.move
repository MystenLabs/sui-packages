module 0xe1b58a2dcd0472f094b35eaaf08ee91443fa50fe4f9b3ee05c50a702426cef45::scrab {
    struct SCRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAB>(arg0, 6, b"SCRAB", b"SUI CRAB", b"The degenerate SUI mogul, pincher of charts and normies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crab_e90bc268cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

