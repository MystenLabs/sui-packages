module 0xa25b122878394e681e442a581b794edaf1d33ffa11d30b8cb8c0efc9d0fa2c5e::gars {
    struct GARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARS>(arg0, 9, b"GARS", b"Garfield S", b"Garfield on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46b0e4cd-de44-425c-948d-1c8bdc765da7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

