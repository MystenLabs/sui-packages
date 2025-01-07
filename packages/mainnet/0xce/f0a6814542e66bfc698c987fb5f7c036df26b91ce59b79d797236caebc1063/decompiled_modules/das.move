module 0xcef0a6814542e66bfc698c987fb5f7c036df26b91ce59b79d797236caebc1063::das {
    struct DAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAS>(arg0, 6, b"DAS", b"Dogaisui", b"First AI-driven memecoin dog ever on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_4278_bfe47ff0b4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

