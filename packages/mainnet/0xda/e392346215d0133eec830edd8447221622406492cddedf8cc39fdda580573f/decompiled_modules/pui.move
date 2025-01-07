module 0xdae392346215d0133eec830edd8447221622406492cddedf8cc39fdda580573f::pui {
    struct PUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUI>(arg0, 6, b"Pui", b"PuiPui", b"Welcome to PUIPUI town losers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moon_ea3682b2d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

