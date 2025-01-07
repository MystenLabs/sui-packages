module 0xe3614a21e2286ad757cb37baa3e7f5a659338b9701f2f2814a3551ad9674618b::suidon {
    struct SUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDON>(arg0, 6, b"SUIDON", b"Suidon", b"Suidon awakens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/posuidon_logo_f20cc454b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

