module 0x7d72d85cd8b570555e3728980f90d440986fc9f1f1add93a0a9e0684b62c5048::benhut {
    struct BENHUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENHUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENHUT>(arg0, 6, b"BENHUT", b"BEN WIF HAT", x"42454e20776966204841540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12zzz_d9c81c6a4c.mp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENHUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENHUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

