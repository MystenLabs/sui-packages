module 0xf2850714ff1a61f143343af2cd60e89daafe2c4b16a291109a94e3c509c7addd::dgm {
    struct DGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGM>(arg0, 6, b"DGM", b"Dogemon", b"Dogemon the cosmic dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dme_46c965245f.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

