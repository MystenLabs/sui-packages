module 0xec54799952bc541dbc438b7a7bd7f1a427b52968b520eca65be95674551c67b0::chattay {
    struct CHATTAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHATTAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHATTAY>(arg0, 9, b"CHATTAY", b"Sai nua chat tay Dole", b"Deo sai duoc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9e1cea4f781c15f638523251788ef719blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHATTAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHATTAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

