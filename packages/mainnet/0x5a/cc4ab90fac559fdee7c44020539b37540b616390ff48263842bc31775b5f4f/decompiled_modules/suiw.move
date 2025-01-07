module 0x5acc4ab90fac559fdee7c44020539b37540b616390ff48263842bc31775b5f4f::suiw {
    struct SUIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIW>(arg0, 6, b"SUIW", b"SUIWave", b"SUIWAVE is revolutionizing the SUI crypto space with the first volume bot on the SUI eco system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwave_logo_6be5e018ee.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

