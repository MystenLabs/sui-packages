module 0xdc2c723122cc61094cadfe3285b19eb40eb2be83d3b1f5d7f530d48139160e7f::mafia {
    struct MAFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAFIA>(arg0, 9, b"MAFIA", b"Mafia", b"Mafia Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/277beb5d-0d45-4ef6-a6fb-4254ac34c26b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAFIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

