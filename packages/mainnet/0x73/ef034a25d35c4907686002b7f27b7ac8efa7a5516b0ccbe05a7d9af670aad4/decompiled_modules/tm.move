module 0x73ef034a25d35c4907686002b7f27b7ac8efa7a5516b0ccbe05a7d9af670aad4::tm {
    struct TM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TM>(arg0, 9, b"TM", b"TIMO", b"TIMO NETWORK meme token for r wewe project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c018138-6aae-4b51-a029-575a10525f8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TM>>(v1);
    }

    // decompiled from Move bytecode v6
}

