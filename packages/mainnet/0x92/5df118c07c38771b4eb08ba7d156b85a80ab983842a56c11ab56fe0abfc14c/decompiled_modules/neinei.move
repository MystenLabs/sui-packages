module 0x925df118c07c38771b4eb08ba7d156b85a80ab983842a56c11ab56fe0abfc14c::neinei {
    struct NEINEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEINEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEINEI>(arg0, 6, b"NeiNei", b"Red Dog NEINEI", b"The Chinese Neiro dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007418_d664a51c89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEINEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEINEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

