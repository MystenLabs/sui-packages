module 0x9a37a7b9283f0ac44e3dca7d841ecf438a10a6cc2cdb7882e748e145e81d3704::marvel {
    struct MARVEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVEL>(arg0, 9, b"MARVEL", b"Deadpool", b"Marvel Jesus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94779883-287a-4eee-b2be-8ae51aab31a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARVEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

