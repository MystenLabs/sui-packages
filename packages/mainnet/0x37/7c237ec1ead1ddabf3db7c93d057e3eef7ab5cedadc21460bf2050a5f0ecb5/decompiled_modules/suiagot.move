module 0x377c237ec1ead1ddabf3db7c93d057e3eef7ab5cedadc21460bf2050a5f0ecb5::suiagot {
    struct SUIAGOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAGOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAGOT>(arg0, 6, b"SUIAGOT", b"SUIAGOTCHI", b"suiagotchi_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/53_C9_B862_7477_43_EB_869_B_ADAD_07321_F20_a8c46e41d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAGOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAGOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

