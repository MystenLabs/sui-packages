module 0x1b9eb3987c639c6eb2ade3c746650d16f99efd5246402735fb9e51f4ac97289f::rusty {
    struct RUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSTY>(arg0, 6, b"RUSTY", b"RUSTY ON SUI", b"$rusty first dog on youtube ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zj_C23ta_AA_Apf_T_f0b3f5a3f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

