module 0x20da458ea147ebf19bb875d9665e063ba5c4b7f005e20b7d8c7abdf1537b78::yucat {
    struct YUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUCAT>(arg0, 9, b"YUCAT", b"YUGO", b"YuCat is a brand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1674a90-2f83-4c75-b1c2-55963746297f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

