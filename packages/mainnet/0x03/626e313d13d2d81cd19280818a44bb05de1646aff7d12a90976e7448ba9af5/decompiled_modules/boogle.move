module 0x3626e313d13d2d81cd19280818a44bb05de1646aff7d12a90976e7448ba9af5::boogle {
    struct BOOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOGLE>(arg0, 6, b"BOOGLE", b"Sui Boogle", b"Boogle Dream's adventure is about to begin, the most powerful memecoin on the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014213_46826f6e1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

