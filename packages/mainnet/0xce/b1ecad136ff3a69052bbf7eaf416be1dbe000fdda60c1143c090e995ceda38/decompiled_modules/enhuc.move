module 0xceb1ecad136ff3a69052bbf7eaf416be1dbe000fdda60c1143c090e995ceda38::enhuc {
    struct ENHUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENHUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENHUC>(arg0, 9, b"ENHUC", b"Baokhanh", b"Dau", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbc69365-214b-4f04-ae2f-b08210c91859.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENHUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENHUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

