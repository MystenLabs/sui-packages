module 0xb330bb78c3597c3695da600c7b6a9d304f1ea30a2027cbfc7d6107334aca466d::moe {
    struct MOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOE>(arg0, 9, b"MOE", b"MOEMOE", b"Unltra MOEMOE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35cd1ddb-cbbe-4074-ad24-8471968ef4ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

