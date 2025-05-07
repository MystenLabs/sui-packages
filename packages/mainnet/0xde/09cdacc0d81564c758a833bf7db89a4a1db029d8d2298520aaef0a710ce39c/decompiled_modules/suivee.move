module 0xde09cdacc0d81564c758a833bf7db89a4a1db029d8d2298520aaef0a710ce39c::suivee {
    struct SUIVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVEE>(arg0, 6, b"SUIVEE", b"Suivee Pokemon", b"Suivee is a small, mammalian, quadrupedal Pokemon with primarily blue fur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidu7ti3drpkupnz4phqchuyh25yab6cwwrtrrzyqvmupj42psy6um")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIVEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

