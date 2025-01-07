module 0x61988f2f1bc930b5123c6563d9726512ba055206c8aeaf749cb2e54c3b15cb29::helene {
    struct HELENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELENE>(arg0, 6, b"Helene", b"Helene cat", b"A CAT hurricane community driven", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013585_22676dd90d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

