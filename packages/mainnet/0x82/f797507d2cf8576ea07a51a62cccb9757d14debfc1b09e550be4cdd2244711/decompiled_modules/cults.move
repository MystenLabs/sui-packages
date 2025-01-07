module 0x82f797507d2cf8576ea07a51a62cccb9757d14debfc1b09e550be4cdd2244711::cults {
    struct CULTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULTS>(arg0, 6, b"CULTS", b"CultOfSUI", b"Welcome to The Cult of SUI. $CULTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CULT_766a93c194.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

