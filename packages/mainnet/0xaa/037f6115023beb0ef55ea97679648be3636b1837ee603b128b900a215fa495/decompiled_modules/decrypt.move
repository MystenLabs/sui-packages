module 0xaa037f6115023beb0ef55ea97679648be3636b1837ee603b128b900a215fa495::decrypt {
    struct DECRYPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECRYPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECRYPT>(arg0, 9, b"DECRYPT", b"De cryp", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dcd8ced-c03a-4340-9cae-1110360acdfd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECRYPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECRYPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

