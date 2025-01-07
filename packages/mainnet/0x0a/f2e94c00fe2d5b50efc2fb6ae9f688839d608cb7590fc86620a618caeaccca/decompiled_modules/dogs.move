module 0xaf2e94c00fe2d5b50efc2fb6ae9f688839d608cb7590fc86620a618caeaccca::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 9, b"DOGS", b"Dogs coin", b"Dogs is meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec13dd14-86e3-4333-b7d5-c844fddd788a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

