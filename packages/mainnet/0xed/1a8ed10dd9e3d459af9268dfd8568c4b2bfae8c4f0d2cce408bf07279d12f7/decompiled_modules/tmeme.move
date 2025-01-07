module 0xed1a8ed10dd9e3d459af9268dfd8568c4b2bfae8c4f0d2cce408bf07279d12f7::tmeme {
    struct TMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMEME>(arg0, 9, b"TMEME", b"Trumpmeme", b"Trump can lead the world with trumpmeme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f18f604-808a-4dcc-b0c4-2b55861a7426.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

