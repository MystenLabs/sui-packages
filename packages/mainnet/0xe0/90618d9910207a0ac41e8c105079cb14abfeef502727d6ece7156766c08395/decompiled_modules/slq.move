module 0xe090618d9910207a0ac41e8c105079cb14abfeef502727d6ece7156766c08395::slq {
    struct SLQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLQ>(arg0, 9, b"SLQ", b"Slique ", b"A profitable project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1689b6e2-0f00-4e95-89ba-8dc3a0820b05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

