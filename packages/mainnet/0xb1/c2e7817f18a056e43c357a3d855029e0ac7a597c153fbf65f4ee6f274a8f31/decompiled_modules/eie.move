module 0xb1c2e7817f18a056e43c357a3d855029e0ac7a597c153fbf65f4ee6f274a8f31::eie {
    struct EIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIE>(arg0, 6, b"EIE", b"Enough is Enough", x"54686520496c6c756d696e61746920636172642067616d6520746861742061636375726174656c792070726564696374656420446f6e616c64205472756d70277320617373617373696e6174696f6e2e0a0a456e6f75676820697320456e6f7567680a0a417420616e792074696d65202c20617420616e7920706c616365202c206f757220736e69706572732063616e2064726f7020796f75202e20486176652061206e69636520646179202e0a200a506c61792074686973206361726420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730527803592.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

