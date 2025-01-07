module 0xec1ed828be7a3b1c13dca41199660aab3f5c037c7a2bd8346bcd821c0034adda::weve {
    struct WEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEVE>(arg0, 9, b"WEVE", b"MUSHLO", b"MUSHLO is a meme inspired by the spirit of adventure and freedom. With MUSHLO, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1315f9be-555c-47d6-9190-82152122ce39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

