module 0xbf9ab5ae90c551f777cb319c6e4194b6005d6cd778f555c2d429e73d23f5b3a9::lighthouse {
    struct LIGHTHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGHTHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGHTHOUSE>(arg0, 6, b"LIGHTHOUSE", b"Lighthouse of Sui", b"Guiding the way through Suis dark waters. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lighthouse_da7cdb6e0a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGHTHOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIGHTHOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

