module 0x588379745d38e350abb410a776ef33249ae2cb43e84c28581efbd1f1cf54029b::ksn1 {
    struct KSN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSN1>(arg0, 9, b"KSN1", b"Ksn", b"Ksn123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7fdf0a1d-1cfd-4c81-819d-106a73e2fed4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSN1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSN1>>(v1);
    }

    // decompiled from Move bytecode v6
}

