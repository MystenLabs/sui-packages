module 0x6cfc8dba5483fa41d25ce8dbc72e28d4f5a062ca3e54c0c45a273bb494a5c302::doges {
    struct DOGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGES>(arg0, 9, b"DOGES", b"DOGESUI", b"Hello world, DOGES is coming! Department of Government Efficiency. DOGES is meme coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f3035ca-d7b9-4eae-b136-3f075a713bcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGES>>(v1);
    }

    // decompiled from Move bytecode v6
}

