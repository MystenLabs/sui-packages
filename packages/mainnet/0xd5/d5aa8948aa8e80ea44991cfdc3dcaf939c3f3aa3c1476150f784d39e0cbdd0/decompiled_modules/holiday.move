module 0xd5d5aa8948aa8e80ea44991cfdc3dcaf939c3f3aa3c1476150f784d39e0cbdd0::holiday {
    struct HOLIDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLIDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLIDAY>(arg0, 9, b"HOLIDAY", b"HolidayTK", b"Holiday Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/502d6fd2-01ca-4b83-96bc-acc89dd8c78d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLIDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLIDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

