module 0xf56696d3530726fb818eecb70e1c2846a08d3214bf9259371a151feac04cc1f7::diip {
    struct DIIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIIP>(arg0, 6, b"Diip", b"Diip buuk", x"4e6f7468696e672077696c6c2068617070656e20696e20686572650a4a7573742077616e6e61207361792077656e2064656570207465736e65742072657761616161616172640a0a4e6f207467206e6f207467206e6f20776562206e6f20627579", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730448513970.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

