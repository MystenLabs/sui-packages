module 0x46764ae754f2e2fcecfff8f3248c9b5161c64c64dfc872572ca3dd5e82868e92::aliec {
    struct ALIEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEC>(arg0, 6, b"ALIEC", b"Alienware", b"MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Alienware_logo_2560x1440_a_ae_6674a997f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

