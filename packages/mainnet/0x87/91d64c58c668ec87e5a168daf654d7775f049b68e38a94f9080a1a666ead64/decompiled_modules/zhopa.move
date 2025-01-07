module 0x8791d64c58c668ec87e5a168daf654d7775f049b68e38a94f9080a1a666ead64::zhopa {
    struct ZHOPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHOPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHOPA>(arg0, 9, b"ZHOPA", b"Popa", b"what is popa - this is zhopa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df0ade73-1e76-461d-8f6b-3ceb66dbfb1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHOPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHOPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

