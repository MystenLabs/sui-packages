module 0x3df891517baaecb1cb20dcdff9d02816908bd2e4b7b4618ad22c26f3dbb85955::rob {
    struct ROB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROB>(arg0, 9, b"ROB", b"Robi", b"Jast for fan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e74c54bc-c3c8-421c-a294-6972dcb87b52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROB>>(v1);
    }

    // decompiled from Move bytecode v6
}

