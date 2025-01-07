module 0x61afdf756b33c34c309af1fd69a94f034149a575937814e0efc211ac8e438d78::raca {
    struct RACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACA>(arg0, 9, b"RACA", b"Radiocaca", b"Metaverse, GameFi, Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f68fa8c0-f41e-44e1-8655-9a4d4c33114d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

