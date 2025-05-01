module 0xab4a90dd948f9421b81db640d7fd249ff16fb27fa7960f198787d95b90c6bf8c::lol_sui {
    struct LOL_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL_SUI>(arg0, 9, b"lolSUI", b"LOL Staked SUI", b"LOL Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/eaf631fa-48f3-4376-ba18-4e20cb6030ee/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOL_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

