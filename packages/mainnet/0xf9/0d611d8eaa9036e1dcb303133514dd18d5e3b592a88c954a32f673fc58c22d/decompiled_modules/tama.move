module 0xf90d611d8eaa9036e1dcb303133514dd18d5e3b592a88c954a32f673fc58c22d::tama {
    struct TAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMA>(arg0, 6, b"TAMA", b"Sui Tama", x"4e6f2070616964206d61726b6574696e672e204e6f20696e666c75656e636572732e0a4a7573742074686520636f6d6d756e69747920616e642074686520706f776572206f66202454414d412e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_and_White_House_Real_Estate_Logo_20250428_233129_0000_0c4f0784ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

