module 0xce8af76aaa681469422164a030e464f9bf10f40c4f08425a8b94780b0debf4ff::catkashi {
    struct CATKASHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATKASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATKASHI>(arg0, 9, b"CATKASHI", b"Catkashi Hatake", b"Hero of the hidden leaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/25045100cd4825b21c57de7a2a05af02blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATKASHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATKASHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

