module 0x28ba99933bb748c1cb6891b378049f47e915e4bd16cbc955c47e71b7cc909267::suwoof {
    struct SUWOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWOOF>(arg0, 6, b"SUWOOF", b"SUIWOOF", b"Woof! Woof! SuiWoof is a blue doge build , the community Of Suiiiiii..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000075266_41c58f3d9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

