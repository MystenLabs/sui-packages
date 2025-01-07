module 0xc60f839d293296a62d4a5b56eb3c7ac449c7bca08173138c6c970bc0454ec7ab::glc {
    struct GLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLC>(arg0, 9, b"GLC", b"Garlic", b"Garlic meme token. Watch out  it's potent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7178adf-436e-455a-889b-95f0efc6036a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

