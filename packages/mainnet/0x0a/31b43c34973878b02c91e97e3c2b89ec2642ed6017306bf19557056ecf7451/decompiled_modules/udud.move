module 0xa31b43c34973878b02c91e97e3c2b89ec2642ed6017306bf19557056ecf7451::udud {
    struct UDUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDUD>(arg0, 9, b"UDUD", b"UdudOnSui", b"This udud on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/877fb6c1-5428-4f0f-a699-bd9ab8bf6a0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UDUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

