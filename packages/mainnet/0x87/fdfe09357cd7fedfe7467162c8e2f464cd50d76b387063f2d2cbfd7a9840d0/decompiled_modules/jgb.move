module 0x87fdfe09357cd7fedfe7467162c8e2f464cd50d76b387063f2d2cbfd7a9840d0::jgb {
    struct JGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGB>(arg0, 9, b"JGB", b"WEWE", b"Longtime crypto investment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fea7db7-b00c-4211-8031-5d8120bd33f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

