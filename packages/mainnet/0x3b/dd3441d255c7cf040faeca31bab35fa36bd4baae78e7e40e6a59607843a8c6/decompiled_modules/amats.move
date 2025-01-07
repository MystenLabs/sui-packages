module 0x3bdd3441d255c7cf040faeca31bab35fa36bd4baae78e7e40e6a59607843a8c6::amats {
    struct AMATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMATS>(arg0, 6, b"AMATS", b"AmatSUI", b"AMATS is a madara token launching on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AMATS_a7e40f37fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

