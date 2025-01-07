module 0xdbc9cb0062e481b3f9ab1c91e696c5293318aeb31e9feb8549d935b34a30774::puri {
    struct PURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURI>(arg0, 6, b"PURI", b"Sui Puri", b"Puri is a Star Atlas Community Meme coin powered by the people for the people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002887_576fd5131b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURI>>(v1);
    }

    // decompiled from Move bytecode v6
}

