module 0xec74718ec4aa2b0e4b0107c499ccea9943dd02f2ac3f78b15d9af5402b6fc2dd::parsts {
    struct PARSTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARSTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARSTS>(arg0, 9, b"PARSTS", b"Parst", b"Meme from ast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9a3ac63-8736-4574-9d4e-f2193c731811.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARSTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARSTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

