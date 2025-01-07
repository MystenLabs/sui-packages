module 0xe459619d8077f8e66d6a5220d49b837ecf07b2efe13c50cd7c8c0d1c826fc979::superhippo {
    struct SUPERHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERHIPPO>(arg0, 6, b"SUPERHIPPO", b"SuperHippo", b"Super hippo hero, living in SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/325_70a85d1ed4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

