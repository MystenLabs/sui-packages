module 0x4b14ef47d39014d2659b547a98f2f10d2d82d3ad3326168a62e4c9f086d53dfa::ratatsuille {
    struct RATATSUILLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATATSUILLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATATSUILLE>(arg0, 6, b"RATATSUILLE", b"RATATSUILLE on sui", b"ratatsuille the master cook", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_24_f492a9415b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATATSUILLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATATSUILLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

