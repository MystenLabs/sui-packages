module 0x35d8eeb151654e54b977ed4a83565fadbe3a77bb2952463af4a1ee5b37bdf5b6::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"SuiShib", b"SUISHIB", b"sui on A happy blue Shib", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z_7_rns7_400x400_20557bb4d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

