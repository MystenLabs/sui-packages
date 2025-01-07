module 0xe0d282c962c64c3055e69396e3acd55d61537025f3437099a0c1f4446b15180e::salien {
    struct SALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALIEN>(arg0, 6, b"Salien", b"SUI ALIEN", b"planet sui ALIENS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_d7ca3f8cf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

