module 0x128030fb3a939024616000e80d2ff5247cceccc502cc970f426c22c2ae664eac::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 6, b"Mario", b"Mariosui", b"We are Mario, let's pass the level together and get a new 1000X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241018200217_32b1692ead.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

