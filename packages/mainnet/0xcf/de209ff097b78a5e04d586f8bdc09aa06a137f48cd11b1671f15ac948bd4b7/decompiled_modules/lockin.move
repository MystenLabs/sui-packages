module 0xcfde209ff097b78a5e04d586f8bdc09aa06a137f48cd11b1671f15ac948bd4b7::lockin {
    struct LOCKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKIN>(arg0, 6, b"LOCKIN", b"LOCK IN ON SUI", b"LOCKED IN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9989_d4c0f620b0.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

