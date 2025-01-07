module 0xabf6a83811ffe214b736da65e6ce7cd8958f939d25fe5a9a857e7773f9fb03db::elonxtrump {
    struct ELONXTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONXTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONXTRUMP>(arg0, 9, b"ELONXTRUMP", b"TRUMP", b"Elon and trump will save the America.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34667361-efd7-4569-927f-402044f0ed50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONXTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONXTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

