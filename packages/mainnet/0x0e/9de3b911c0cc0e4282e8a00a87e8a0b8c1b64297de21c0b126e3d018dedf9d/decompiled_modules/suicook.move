module 0xe9de3b911c0cc0e4282e8a00a87e8a0b8c1b64297de21c0b126e3d018dedf9d::suicook {
    struct SUICOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOOK>(arg0, 6, b"Suicook", b"Cooking SUI", b"About to cook something good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zx_D8_H_Ha_EA_Az_Oq3_a65274a5ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

