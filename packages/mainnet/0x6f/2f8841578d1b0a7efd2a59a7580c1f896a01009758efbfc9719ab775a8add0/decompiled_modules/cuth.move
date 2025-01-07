module 0x6f2f8841578d1b0a7efd2a59a7580c1f896a01009758efbfc9719ab775a8add0::cuth {
    struct CUTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTH>(arg0, 9, b"CUTH", b"CuteHub ", b"The cutest city Hub ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ba35900-2868-489d-b781-39ef91fa6842.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

