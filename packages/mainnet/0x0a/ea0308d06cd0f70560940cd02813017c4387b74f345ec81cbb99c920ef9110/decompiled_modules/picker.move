module 0xaea0308d06cd0f70560940cd02813017c4387b74f345ec81cbb99c920ef9110::picker {
    struct PICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKER>(arg0, 9, b"PICKER", b"Wow", b"Let's be fast to know what is next on meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6552cdc-15c0-4338-812b-55482f33230e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

