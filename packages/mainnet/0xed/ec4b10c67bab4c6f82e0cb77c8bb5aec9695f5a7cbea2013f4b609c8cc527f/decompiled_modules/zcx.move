module 0xedec4b10c67bab4c6f82e0cb77c8bb5aec9695f5a7cbea2013f4b609c8cc527f::zcx {
    struct ZCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZCX>(arg0, 9, b"ZCX", b"BH", b"VXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8546159e-4936-4cce-97a0-fb723c4c3fcd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

