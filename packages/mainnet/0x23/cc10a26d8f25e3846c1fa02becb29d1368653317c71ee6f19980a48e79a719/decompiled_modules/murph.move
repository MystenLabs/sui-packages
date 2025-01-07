module 0x23cc10a26d8f25e3846c1fa02becb29d1368653317c71ee6f19980a48e79a719::murph {
    struct MURPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURPH>(arg0, 6, b"MURPH", b"Sui Murph", b"MURPH is so strong Shouldn't try the chain, this beast just grows", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008859_49ef63872b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

