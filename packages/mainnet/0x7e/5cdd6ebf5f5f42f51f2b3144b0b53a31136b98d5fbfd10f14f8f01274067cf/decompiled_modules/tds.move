module 0x7e5cdd6ebf5f5f42f51f2b3144b0b53a31136b98d5fbfd10f14f8f01274067cf::tds {
    struct TDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDS>(arg0, 9, b"TDS", b"ToddSatosh", b"A community driven meme, that supports the question, about Peter Todd being Satoshi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5feb75b3-a4c4-4b99-b9b5-108b7f64702b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

