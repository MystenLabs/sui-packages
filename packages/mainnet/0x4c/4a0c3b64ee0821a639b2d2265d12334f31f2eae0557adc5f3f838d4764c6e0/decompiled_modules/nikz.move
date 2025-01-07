module 0x4c4a0c3b64ee0821a639b2d2265d12334f31f2eae0557adc5f3f838d4764c6e0::nikz {
    struct NIKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKZ>(arg0, 9, b"NIKZ", b"Nikzo", b"Lone Wolf ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a609d2dc-d479-40f8-b186-b80d8de83879.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

