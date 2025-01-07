module 0x33d1145eef800da16e5f4cf0865b7702ec6aacbd1bcfd3d7f8a2d928d3174409::pepes {
    struct PEPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 6, b"PepeS", b"PepeSUI", b"Pepe has been SUI Pilled $PEPSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepe_c3c4085137.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

