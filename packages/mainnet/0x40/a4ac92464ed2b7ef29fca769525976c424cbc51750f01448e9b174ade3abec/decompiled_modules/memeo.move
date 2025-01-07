module 0x40a4ac92464ed2b7ef29fca769525976c424cbc51750f01448e9b174ade3abec::memeo {
    struct MEMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEO>(arg0, 6, b"MEMEO", b"Memeo", b"This aint just another fish in the sea its a whole ocean of potential!  Ready to swim with the big $MEMEO ? Dive in before the tide turns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054685_c1be61bb7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

