module 0xc99cec89596054d0013fc90034b932a2d22ece0691bdd60e8451f5f1c2991253::ip {
    struct IP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IP>(arg0, 9, b"IP", b"Story", b"Token of story protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01cedd27-0c3a-409c-9fc3-805390986ba4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IP>>(v1);
    }

    // decompiled from Move bytecode v6
}

