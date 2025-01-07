module 0x129b43a3c0c9be148c6cafafef8973fa66c12e1cae5896ef3a5603cacf19e009::hiwbb {
    struct HIWBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIWBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIWBB>(arg0, 9, b"HIWBB", b"Gha", b"Hj8ija", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85278c31-649a-4bd7-a1fd-ee06e55f3bd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIWBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIWBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

