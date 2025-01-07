module 0xca51ab9ed19b1e687f04446f8c3c6186800344b77ddbfc631eb8ac6a581daf41::seedwaves {
    struct SEEDWAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDWAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDWAVES>(arg0, 9, b"SEEDWAVES", b"SeedWave", b"Latest trending meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a4a9a90-907d-4c6f-812e-dae9b104696b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDWAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEDWAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

