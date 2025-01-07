module 0x7bfb3d3e43675a1f932e4f2fc82e4211209ff76ec7a5ea6be218e58bac8a0ca8::spdg {
    struct SPDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPDG>(arg0, 6, b"SPDG", b"SheepDog", b"I dont even know.. I am a sheep or a Dog?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732298753594.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPDG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

