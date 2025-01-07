module 0x7a3f29b882b98e4700168cef382d81cab63c469ffd9aaeb9a0b6b99de013cd04::can {
    struct CAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAN>(arg0, 9, b"CAN", b"Cryman", b"Top1sever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7e1ff8f-b7ba-4632-934b-24aef1b38384.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

