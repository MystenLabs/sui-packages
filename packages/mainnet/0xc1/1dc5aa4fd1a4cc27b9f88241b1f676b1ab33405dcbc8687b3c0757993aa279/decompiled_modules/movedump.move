module 0xc11dc5aa4fd1a4cc27b9f88241b1f676b1ab33405dcbc8687b3c0757993aa279::movedump {
    struct MOVEDUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDUMP>(arg0, 6, b"MOVEDUMP", b"Movedump.com", b"F*ck movepump I'm going to sleep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movedump_d53c40b57d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

