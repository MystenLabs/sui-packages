module 0x17d9e92412d5bae8a1cfd6e4622e9e50d23bbc4dd75c6db693a4e63974bff877::wshrk {
    struct WSHRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSHRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSHRK>(arg0, 9, b"WSHRK", b"Wifshark", b"The next wif doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/055617e1-d9c2-4602-a0c7-3325b1e35d86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSHRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSHRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

