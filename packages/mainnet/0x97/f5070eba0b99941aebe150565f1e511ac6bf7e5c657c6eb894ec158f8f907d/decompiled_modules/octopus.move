module 0x97f5070eba0b99941aebe150565f1e511ac6bf7e5c657c6eb894ec158f8f907d::octopus {
    struct OCTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUS>(arg0, 6, b"OCTOPUS", b"Octopus", b"Unofficial mascot on sui. Every sea chain needs octopus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9c1e6751_52aa_43f0_a5b3_5732689a24e7_e472c565dc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

