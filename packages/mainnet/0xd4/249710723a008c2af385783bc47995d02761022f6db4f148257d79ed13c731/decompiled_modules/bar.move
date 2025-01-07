module 0xd4249710723a008c2af385783bc47995d02761022f6db4f148257d79ed13c731::bar {
    struct BAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAR>(arg0, 9, b"BAR", b"Crypto Bar", b"Token from Crypto Bar telegram channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb61d8df-037c-45f7-b5a2-22c85596132e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

