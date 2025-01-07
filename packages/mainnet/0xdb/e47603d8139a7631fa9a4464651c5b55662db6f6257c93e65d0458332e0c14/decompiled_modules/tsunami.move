module 0xdbe47603d8139a7631fa9a4464651c5b55662db6f6257c93e65d0458332e0c14::tsunami {
    struct TSUNAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUNAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUNAMI>(arg0, 6, b"TSUNAMI", b"Sui Tsunami", b"A tidal force that sweeps through the Sui seas. Ride the wave or get washed away. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tsunami_94fa976df4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUNAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUNAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

