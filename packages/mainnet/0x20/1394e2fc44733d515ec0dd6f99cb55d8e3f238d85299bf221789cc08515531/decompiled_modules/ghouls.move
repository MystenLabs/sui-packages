module 0x201394e2fc44733d515ec0dd6f99cb55d8e3f238d85299bf221789cc08515531::ghouls {
    struct GHOULS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOULS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOULS>(arg0, 6, b"GHOULS", b"TRICK or TREAT Ghouls", b"TOT GHOULS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c20c7e73_8aba_43f2_9d17_4474acca2475_d2cf44c99e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOULS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOULS>>(v1);
    }

    // decompiled from Move bytecode v6
}

