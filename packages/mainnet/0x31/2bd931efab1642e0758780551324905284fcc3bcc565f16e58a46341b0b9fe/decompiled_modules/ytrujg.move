module 0x312bd931efab1642e0758780551324905284fcc3bcc565f16e58a46341b0b9fe::ytrujg {
    struct YTRUJG has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTRUJG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YTRUJG>(arg0, 9, b"YTRUJG", b"TINGFDT", b"okiu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79a57b57-e7e7-46e2-b5b5-35f97f8299ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YTRUJG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YTRUJG>>(v1);
    }

    // decompiled from Move bytecode v6
}

