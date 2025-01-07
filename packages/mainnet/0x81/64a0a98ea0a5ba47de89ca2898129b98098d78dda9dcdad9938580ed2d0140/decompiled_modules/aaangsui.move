module 0x8164a0a98ea0a5ba47de89ca2898129b98098d78dda9dcdad9938580ed2d0140::aaangsui {
    struct AAANGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAANGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAANGSUI>(arg0, 6, b"AAANGSUI", b"AANG SUI", b"AAng is the only Sui Bender", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736243279368.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAANGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAANGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

