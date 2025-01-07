module 0x97d94190004514cba0f1094b8c3d6ca9554ce55b11ee9e871c68eba5035d6e3d::sapt {
    struct SAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPT>(arg0, 6, b"sAPT", b"Aptos Powered by Sui", b"Why Aptos When Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tu_HF_27_8_400x400_1_224a8df963.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

