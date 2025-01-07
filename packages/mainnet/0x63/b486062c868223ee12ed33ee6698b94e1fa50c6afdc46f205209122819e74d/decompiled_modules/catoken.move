module 0x63b486062c868223ee12ed33ee6698b94e1fa50c6afdc46f205209122819e74d::catoken {
    struct CATOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATOKEN>(arg0, 9, b"CATOKEN", b"MEOW", b"Cat token funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5b0f08c-9747-46b1-b5d0-75481ce8a9f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

