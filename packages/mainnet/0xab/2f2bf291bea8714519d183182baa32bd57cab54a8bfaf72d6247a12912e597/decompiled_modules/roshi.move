module 0xab2f2bf291bea8714519d183182baa32bd57cab54a8bfaf72d6247a12912e597::roshi {
    struct ROSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSHI>(arg0, 6, b"ROSHI", b"PepeRoshiSui", b"the Kamehameha, in the world of the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000348_50daa24de1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

