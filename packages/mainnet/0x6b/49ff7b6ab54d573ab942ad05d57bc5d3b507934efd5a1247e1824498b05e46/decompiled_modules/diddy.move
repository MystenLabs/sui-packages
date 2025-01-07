module 0x6b49ff7b6ab54d573ab942ad05d57bc5d3b507934efd5a1247e1824498b05e46::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", b"P.DIDDY", b"HELP DIDDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DIDDY_9ab9c442bb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

