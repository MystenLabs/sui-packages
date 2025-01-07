module 0xceba14ea9d86b5de7daad59504cc04dc665fc6e77a351bb9621459ad2b97b4f6::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 6, b"Savior", b"Save Trenches", b"NO DEV. NO INSIDERS. CTO IT. SUI trenches are cooked. Apes want to eat. I'm here to save it. Send it. The creator will communicate through the comments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_04_39_21_205bb86ae0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

