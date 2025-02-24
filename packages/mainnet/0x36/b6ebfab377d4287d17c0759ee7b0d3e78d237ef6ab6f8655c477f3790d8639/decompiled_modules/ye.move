module 0x36b6ebfab377d4287d17c0759ee7b0d3e78d237ef6ab6f8655c477f3790d8639::ye {
    struct YE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YE>(arg0, 9, b"YE", b"Yeezy", b"frm Ye", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f901607a-dd96-4b08-8706-c1929eae5e92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YE>>(v1);
    }

    // decompiled from Move bytecode v6
}

