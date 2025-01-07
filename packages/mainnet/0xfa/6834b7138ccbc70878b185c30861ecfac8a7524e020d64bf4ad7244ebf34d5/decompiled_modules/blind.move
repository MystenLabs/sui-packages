module 0xfa6834b7138ccbc70878b185c30861ecfac8a7524e020d64bf4ad7244ebf34d5::blind {
    struct BLIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLIND>(arg0, 6, b"BLIND", b"PepeBlind", b"I don't see anything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blindpepe_626c4f79ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

