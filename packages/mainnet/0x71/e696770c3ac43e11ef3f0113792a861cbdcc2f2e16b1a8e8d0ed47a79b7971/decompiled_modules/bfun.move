module 0x71e696770c3ac43e11ef3f0113792a861cbdcc2f2e16b1a8e8d0ed47a79b7971::bfun {
    struct BFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFUN>(arg0, 9, b"BFUN", b"BLUM FUN", b"BFUN from Blum meme competition. Now, BFUN is the first meme coin in Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59b6c8f3-9655-4da0-9559-d9c630bda7aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

