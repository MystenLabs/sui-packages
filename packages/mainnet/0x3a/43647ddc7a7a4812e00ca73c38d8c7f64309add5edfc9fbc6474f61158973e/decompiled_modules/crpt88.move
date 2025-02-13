module 0x3a43647ddc7a7a4812e00ca73c38d8c7f64309add5edfc9fbc6474f61158973e::crpt88 {
    struct CRPT88 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRPT88, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRPT88>(arg0, 9, b"CRPT88", b"Crypto88", b"Meme coin 88", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a154ef28-887a-4d31-86dd-e8cfa1a83a34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRPT88>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRPT88>>(v1);
    }

    // decompiled from Move bytecode v6
}

