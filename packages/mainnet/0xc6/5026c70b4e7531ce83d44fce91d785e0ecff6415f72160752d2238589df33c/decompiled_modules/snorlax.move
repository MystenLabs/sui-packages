module 0xc65026c70b4e7531ce83d44fce91d785e0ecff6415f72160752d2238589df33c::snorlax {
    struct SNORLAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORLAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNORLAX>(arg0, 6, b"Snorlax", b"SNORLAX ON SUI", b"Hi, its me, Snorlax! Snor lax Im the big, fluffy one who eats a lot and takes the best naps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T8_VCV_h_U_400x400_82f23a8da4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORLAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNORLAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

