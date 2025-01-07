module 0xa42d0caf58a11db8282e1899566a3f2fb87c88aa3d96fa0647897851edbfb81d::DivineFeathercloak {
    struct DIVINEFEATHERCLOAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIVINEFEATHERCLOAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIVINEFEATHERCLOAK>(arg0, 0, b"COS", b"Divine Feathercloak", b"Do not fear, little one. You can unmask yourself here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Divine_Feathercloak.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIVINEFEATHERCLOAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIVINEFEATHERCLOAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

