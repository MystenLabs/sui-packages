module 0x7024bdceba6ff378f5ae7daadb1f8db3c257d7904d824fd8ad12ce6a46a2dc33::memeduck {
    struct MEMEDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEDUCK>(arg0, 9, b"MEMEDUCK", b"Duck", b"Mem duck coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af5f4d8d-a4cf-48a1-af22-cb645059919c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

