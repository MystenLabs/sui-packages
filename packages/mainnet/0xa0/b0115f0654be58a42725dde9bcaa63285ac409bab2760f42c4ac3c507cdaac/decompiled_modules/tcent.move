module 0xa0b0115f0654be58a42725dde9bcaa63285ac409bab2760f42c4ac3c507cdaac::tcent {
    struct TCENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCENT>(arg0, 6, b"Tcent", b"Turtle Cent", b"Get rich or turtle tryin'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/turlecebt_fa6da12a2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

