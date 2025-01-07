module 0x956bd145581f2e3ba6756ff4fbf97b3949f6f4f7e1dbcce43c1b2c278dca409c::felle {
    struct FELLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELLE>(arg0, 6, b"FELLE", b"Felle", b"Felle is here and hes exploring the memeverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241217_093757_104_577ca1b7d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FELLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

