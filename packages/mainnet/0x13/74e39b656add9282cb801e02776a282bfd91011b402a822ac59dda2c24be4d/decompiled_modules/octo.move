module 0x1374e39b656add9282cb801e02776a282bfd91011b402a822ac59dda2c24be4d::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 9, b"OCTO", b"Octopus", b"Octo: be like an octopus - embrace the crypto world with your eight tentacles! Keep all your assets under control! A fun meme token with serious ambitions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bafd810c-57ad-48b8-a543-a965f6d9b526.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

