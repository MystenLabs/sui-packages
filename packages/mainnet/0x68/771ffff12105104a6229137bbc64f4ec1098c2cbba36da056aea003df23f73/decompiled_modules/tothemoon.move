module 0x68771ffff12105104a6229137bbc64f4ec1098c2cbba36da056aea003df23f73::tothemoon {
    struct TOTHEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTHEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTHEMOON>(arg0, 9, b"TOTHEMOON", b"$MOON", b"Meme of gamefi. To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f694504-ae11-4239-bf1d-466b38cbcbfd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTHEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOTHEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

