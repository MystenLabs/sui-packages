module 0xf6b2fd932e1fabb620c7d7bd8f7ee278dbff2af5c6b23e84eab075c8e6dae488::suiw {
    struct SUIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIW>(arg0, 6, b"SUIW", b"SUIWave", b"SUIWAVE is revolutionizing the SUI crypto space with the first volume bot on the SUI eco system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwave_logo_6be5e018ee_43f2532cc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

