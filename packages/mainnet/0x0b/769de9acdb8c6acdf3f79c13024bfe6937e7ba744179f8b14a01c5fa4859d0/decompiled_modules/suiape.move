module 0xb769de9acdb8c6acdf3f79c13024bfe6937e7ba744179f8b14a01c5fa4859d0::suiape {
    struct SUIAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE>(arg0, 6, b"SUIAPE", b"SuiApe", x"5768617473206120636861696e20776974686f757420697473206f776e206170653f2057657265206865726520746f2066697820746861742e0a5468652061706520697320636f6d696e6720736f6f6e20746f20746865202453554920626c6f636b636861696e2e0a24535549415045", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ha_W2_IG_1_400x400_4a30d0f14a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

