module 0x6e58fbba5aeefd7e62ed1f841c9edcc72c4d855fe5e4068413ff1112f2be097e::weeeeeeee {
    struct WEEEEEEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEEEEEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEEEEEEE>(arg0, 9, b"WEEEEEEEE", b"Weee", b"Weeeeeeeeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15388e15-925c-4438-aa20-bee44c3c961c-IMG_20241005_112656.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEEEEEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEEEEEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

