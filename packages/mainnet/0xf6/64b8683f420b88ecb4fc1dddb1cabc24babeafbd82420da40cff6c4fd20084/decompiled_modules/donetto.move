module 0xf664b8683f420b88ecb4fc1dddb1cabc24babeafbd82420da40cff6c4fd20084::donetto {
    struct DONETTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONETTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONETTO>(arg0, 6, b"DONETTO", b"Donetto The Bull", b"https://t.me/DonettoTheBull_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_23_20_28_8b5b4f8bc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONETTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONETTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

