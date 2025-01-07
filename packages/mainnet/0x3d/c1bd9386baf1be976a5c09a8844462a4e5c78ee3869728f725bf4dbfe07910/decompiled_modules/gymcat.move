module 0x3dc1bd9386baf1be976a5c09a8844462a4e5c78ee3869728f725bf4dbfe07910::gymcat {
    struct GYMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYMCAT>(arg0, 9, b"GYMCAT", b"CAT IN GYM ", b"ONLY FOR GYMER CAT COMMUNITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ab12312ed92655914f02a9375a38608cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GYMCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYMCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

