module 0x81291d2f955b66e009235c9abe9963e59902781070e72e727745cb62cbaaf834::kiwi {
    struct KIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIWI>(arg0, 6, b"KIWI", b"Kiwi on Sui", b"First Kiwi on Sui ! These kiwi birds are literally just walking kiwi fruit, it's kinda wild!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kiki_d2a1e70c63.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

