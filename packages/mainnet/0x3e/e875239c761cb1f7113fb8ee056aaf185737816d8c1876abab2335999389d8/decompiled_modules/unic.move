module 0x3ee875239c761cb1f7113fb8ee056aaf185737816d8c1876abab2335999389d8::unic {
    struct UNIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIC>(arg0, 9, b"UNIC", b"FluffyUnic", b"Magical gains and rainbow profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84af91d6-2d61-409d-909d-21d7df031375.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

