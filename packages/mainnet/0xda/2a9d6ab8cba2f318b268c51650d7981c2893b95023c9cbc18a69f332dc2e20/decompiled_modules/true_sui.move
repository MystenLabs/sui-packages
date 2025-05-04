module 0xda2a9d6ab8cba2f318b268c51650d7981c2893b95023c9cbc18a69f332dc2e20::true_sui {
    struct TRUE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUE_SUI>(arg0, 9, b"trueSUI", b"Truesui Staked SUI", b"True sui is a little sui that tell the truth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/d4874b6d-f762-461a-817d-fa2e1a9f3b32/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUE_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUE_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

