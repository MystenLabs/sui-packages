module 0x6c5e4e3473ba9caa81424154bbf6d892f5779fc4608dd85a519cedd43103dd82::zel {
    struct ZEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEL>(arg0, 9, b"ZEL", b"Zelenskyy", b"0x01e07df8db71f6f24b8f5829c8ce250d5c2bb5e3adae7bc60cd517f4a552d72b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62ebbf4c-06ed-4a57-b4d8-222fa1583ae6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

