module 0x23905730e0e7ebed29098a7cb8ef7eda1930e7dc46eb21c4c48fdecc86ef339::fasui {
    struct FASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASUI>(arg0, 9, b"FaSui", b"Football Arena Sui ", b"First ever telegram betting bot in the globe is live ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/191b0e0bf03aed459854665e5288811dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

