module 0x2e7cd4b127767a6824b0afe6c09db1dabd60539fa0f7288d2660bffb77a73217::whattelse {
    struct WHATTELSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHATTELSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHATTELSE>(arg0, 9, b"WHATTELSE", b"Whatttt", b"Whaaaat this ? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0719082b-19ee-4c1a-914f-6d0fba79bc63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHATTELSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHATTELSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

