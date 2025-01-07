module 0xbe3519641f0ad4be84b4c7159cf58a9b81aa4f0b173e2e1a79a967684091d96c::slion {
    struct SLION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLION>(arg0, 6, b"SLION", b"SUI LION", b"After falling into the SUI, the former king of the jungle SUILION, evolved and acquired a tail to adapt to his new surroundings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/41251851_7afd_417b_93c8_ae0e31fb8f4b_1391e69b9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLION>>(v1);
    }

    // decompiled from Move bytecode v6
}

