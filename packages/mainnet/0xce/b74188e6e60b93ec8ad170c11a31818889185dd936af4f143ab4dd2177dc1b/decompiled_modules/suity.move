module 0xceb74188e6e60b93ec8ad170c11a31818889185dd936af4f143ab4dd2177dc1b::suity {
    struct SUITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITY>(arg0, 6, b"SUITY", b"SUITY the Cat", b"The sweetest and cutest cat on SUI is SUITY. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfpf_411a64bb01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

