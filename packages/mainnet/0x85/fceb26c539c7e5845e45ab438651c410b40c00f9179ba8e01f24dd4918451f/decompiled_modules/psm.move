module 0x85fceb26c539c7e5845e45ab438651c410b40c00f9179ba8e01f24dd4918451f::psm {
    struct PSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSM>(arg0, 6, b"PSM", b"PINK SUI", b"PINK SMILE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/67100f7aca525332d913b275_logo_big2_26a3c491e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

