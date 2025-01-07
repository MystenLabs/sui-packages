module 0xa4359a545b3989929c713268d703a50bdd8af56f46998eb5d8499b25a20983ec::caip {
    struct CAIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAIP>(arg0, 6, b"CAIP", b"CyberAIpes", b"CyberAipes are the supreme intelligence!! Dive in a world of SuperAipes and their fascinating Cybersociety.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731491202721.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

