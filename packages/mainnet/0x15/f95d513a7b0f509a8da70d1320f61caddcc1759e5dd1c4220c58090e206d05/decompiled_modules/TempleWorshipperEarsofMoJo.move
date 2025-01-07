module 0x15f95d513a7b0f509a8da70d1320f61caddcc1759e5dd1c4220c58090e206d05::TempleWorshipperEarsofMoJo {
    struct TEMPLEWORSHIPPEREARSOFMOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLEWORSHIPPEREARSOFMOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLEWORSHIPPEREARSOFMOJO>(arg0, 0, b"COS", b"Temple Worshipper Ears of MoJo", b"Worship not the Horror... keep it close... keep it safe...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Temple_Worshipper_Ears_of_MoJo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPLEWORSHIPPEREARSOFMOJO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLEWORSHIPPEREARSOFMOJO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

