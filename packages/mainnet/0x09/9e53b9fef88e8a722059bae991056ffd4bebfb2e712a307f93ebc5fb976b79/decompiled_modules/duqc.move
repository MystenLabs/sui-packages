module 0x99e53b9fef88e8a722059bae991056ffd4bebfb2e712a307f93ebc5fb976b79::duqc {
    struct DUQC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUQC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUQC>(arg0, 9, b"DUQC", b"DUCKQUAC", b"Meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a607d655-064e-4733-a5d7-71661677e133.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUQC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUQC>>(v1);
    }

    // decompiled from Move bytecode v6
}

