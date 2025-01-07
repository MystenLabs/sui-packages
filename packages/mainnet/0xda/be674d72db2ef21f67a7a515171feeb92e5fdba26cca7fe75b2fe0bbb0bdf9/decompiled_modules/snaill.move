module 0xdabe674d72db2ef21f67a7a515171feeb92e5fdba26cca7fe75b2fe0bbb0bdf9::snaill {
    struct SNAILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAILL>(arg0, 6, b"SNAILL", b"Snaillls on Sui", x"4272696e67696e6720796f7520636f6d6d756e6974792c2076616c756520616e6420666169726e6573732e2057652061726520246e61696c73206f6e20537569210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snail_s_on_Sui_be9a5b22d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

