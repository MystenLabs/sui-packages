module 0x2dcbdee7846fd7dc19c757c4065c672d102e36a52f17a89638cb7790a44452cc::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAT>(arg0, 9, b"CCAT", b"C CAT", b"CUSTOME CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8981b697-60c0-426c-8289-ee64a6acb271.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

