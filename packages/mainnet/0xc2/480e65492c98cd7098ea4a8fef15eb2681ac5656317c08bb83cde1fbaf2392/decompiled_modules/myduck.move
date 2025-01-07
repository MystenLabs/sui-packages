module 0xc2480e65492c98cd7098ea4a8fef15eb2681ac5656317c08bb83cde1fbaf2392::myduck {
    struct MYDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYDUCK>(arg0, 9, b"MYDUCK", b"Duck", b"New token duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9845a2e4-26c4-4caa-8759-a1d18a81816c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

