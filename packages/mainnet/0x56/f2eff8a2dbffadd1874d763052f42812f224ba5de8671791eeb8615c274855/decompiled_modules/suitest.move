module 0x56f2eff8a2dbffadd1874d763052f42812f224ba5de8671791eeb8615c274855::suitest {
    struct SUITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEST>(arg0, 6, b"SUITEST", b"Sui Test", b"Test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUITESTLOGO_bb764d9eb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

