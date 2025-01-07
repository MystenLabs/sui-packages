module 0x1971c9c3ceb73110557a8a6a66d2915a11d94062ecd7dcb896c6fe092380145a::holiday {
    struct HOLIDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLIDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLIDAY>(arg0, 9, b"HOLIDAY", b"HolidayTK", b"Holiday Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02c85972-8602-4006-8c63-33de50448313.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLIDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLIDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

