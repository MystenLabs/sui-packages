module 0xdba8396bc5d949bf10ae1ba7f39a9854b7a9f4fb1b6808ad125e74856a4ff63c::kekui {
    struct KEKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKUI>(arg0, 6, b"KEKUI", b"KEKUI ON SUI", b"KEKUI ON SUI Ticker:$KEKUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st1_997f541932.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

