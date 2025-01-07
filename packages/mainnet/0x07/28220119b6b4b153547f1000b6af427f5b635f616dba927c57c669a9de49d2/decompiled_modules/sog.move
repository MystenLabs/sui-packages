module 0x728220119b6b4b153547f1000b6af427f5b635f616dba927c57c669a9de49d2::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SOG", b"SEALDOGSUI", b"'We are arriving at SuiAI after great success in SUI and MovePump. We have come to add value and bring our holders into the SuiAI ecosystem. We are going to become the largest meme coin on SuiAI. Come join us!'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Captura_de_tela_2024_12_24_092907_0b6832bd3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

