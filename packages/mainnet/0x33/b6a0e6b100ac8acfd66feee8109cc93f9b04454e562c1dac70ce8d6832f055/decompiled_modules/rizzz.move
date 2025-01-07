module 0x33b6a0e6b100ac8acfd66feee8109cc93f9b04454e562c1dac70ce8d6832f055::rizzz {
    struct RIZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZZ>(arg0, 6, b"RIZZZ", b"RizzDog", b"Dog With Attitude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1278_2_881271df4e.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

