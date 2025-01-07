module 0xaf852bcdac95af3f73510de20f37de78c358a4b2a13ac932ef0527ad39666bc0::suitober {
    struct SUITOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOBER>(arg0, 6, b"SUITOBER", b"Sui October", b"It's october... or SUITOBER?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gfdfgddddddddddddddddddddddddddddd_b776ed1121.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

