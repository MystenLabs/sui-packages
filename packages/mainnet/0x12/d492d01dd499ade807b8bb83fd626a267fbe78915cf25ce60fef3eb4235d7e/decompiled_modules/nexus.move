module 0x12d492d01dd499ade807b8bb83fd626a267fbe78915cf25ce60fef3eb4235d7e::nexus {
    struct NEXUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXUS>(arg0, 6, b"NEXUS", b"NEXUS NETWORK", b"Nexus is pioneering zero-knowledge proofs to advance critical digital infrastructure, optimizing for next-generation performance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3766_eb5734f563.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEXUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

