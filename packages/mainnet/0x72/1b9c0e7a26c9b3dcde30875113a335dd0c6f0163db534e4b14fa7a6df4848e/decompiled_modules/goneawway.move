module 0x721b9c0e7a26c9b3dcde30875113a335dd0c6f0163db534e4b14fa7a6df4848e::goneawway {
    struct GONEAWWAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONEAWWAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONEAWWAY>(arg0, 9, b"GONEAWWAY", b"Gone away", b"Go away", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7493aab8-e6bc-4cdf-a8c6-f651de2f1c08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONEAWWAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GONEAWWAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

