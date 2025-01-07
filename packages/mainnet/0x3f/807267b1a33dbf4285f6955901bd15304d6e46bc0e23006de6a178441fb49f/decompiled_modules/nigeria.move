module 0x3f807267b1a33dbf4285f6955901bd15304d6e46bc0e23006de6a178441fb49f::nigeria {
    struct NIGERIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGERIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGERIA>(arg0, 9, b"NIGERIA", b"Nig", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eebd21de-1a9f-4e57-9e2a-d8f6a1d6a3a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGERIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIGERIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

