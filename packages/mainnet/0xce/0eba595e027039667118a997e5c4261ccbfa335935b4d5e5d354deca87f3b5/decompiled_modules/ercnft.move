module 0xce0eba595e027039667118a997e5c4261ccbfa335935b4d5e5d354deca87f3b5::ercnft {
    struct ERCNFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERCNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERCNFT>(arg0, 9, b"ERCNFT", b"ERC", b"Complex heads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b43abd7f-4076-4543-9a26-b6328aca6c4f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERCNFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERCNFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

