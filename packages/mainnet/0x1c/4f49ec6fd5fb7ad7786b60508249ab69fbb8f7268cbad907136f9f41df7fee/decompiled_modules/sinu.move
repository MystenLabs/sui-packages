module 0x1c4f49ec6fd5fb7ad7786b60508249ab69fbb8f7268cbad907136f9f41df7fee::sinu {
    struct SINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINU>(arg0, 6, b"SINU", b"Sui inu", b"Sui inu meme Project on movepump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027954_83a32b7ff2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

