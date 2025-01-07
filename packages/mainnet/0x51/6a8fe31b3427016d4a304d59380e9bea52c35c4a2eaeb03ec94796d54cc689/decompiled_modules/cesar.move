module 0x516a8fe31b3427016d4a304d59380e9bea52c35c4a2eaeb03ec94796d54cc689::cesar {
    struct CESAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CESAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CESAR>(arg0, 9, b"CESAR", b"$CESAR", b"Here, upon this very ground, our legion assembles as one, united in purpose and strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d86c8363-1465-418c-ba1a-79baba4e7221.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CESAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CESAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

