module 0xe162180d24b11254c26c748a7cf2233477d5712837c84b88f48f7bdf6d135bff::tpn {
    struct TPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPN>(arg0, 9, b"TPN", b"Teepain", b"Tue current economic situation in Nigeria has been so bad that Nigerians are in pains. Trust naija to however make fun out of every painful situation, hence T-pain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/477e9968-3c8f-4479-9a30-1f107dff76bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

