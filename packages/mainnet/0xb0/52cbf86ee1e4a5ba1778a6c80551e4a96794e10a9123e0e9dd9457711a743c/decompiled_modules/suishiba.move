module 0xb052cbf86ee1e4a5ba1778a6c80551e4a96794e10a9123e0e9dd9457711a743c::suishiba {
    struct SUISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIBA>(arg0, 6, b"SUISHIBA", b"SUI SHIBA", x"54686520466972737420534849424120494e20204d4f564550554d500a0a68747470733a2f2f742e6d652f45544847656d5f63616c6c2f333832", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/suishiba_dbb33bfc29.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

