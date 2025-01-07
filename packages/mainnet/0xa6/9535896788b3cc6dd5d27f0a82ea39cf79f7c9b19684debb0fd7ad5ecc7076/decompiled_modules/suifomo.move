module 0xa69535896788b3cc6dd5d27f0a82ea39cf79f7c9b19684debb0fd7ad5ecc7076::suifomo {
    struct SUIFOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFOMO>(arg0, 6, b"SUIFOMO", b"SUI FOMO", b"SUIFOMO is a platform designed to make token creation accessible to everyone. Our platform allows you to easily create, customize, and launch your own tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_5_Y97_Za_AAAM_1l_dc97d136af.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

