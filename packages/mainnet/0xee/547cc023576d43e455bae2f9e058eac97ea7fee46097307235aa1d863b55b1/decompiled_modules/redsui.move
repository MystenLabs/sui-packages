module 0xee547cc023576d43e455bae2f9e058eac97ea7fee46097307235aa1d863b55b1::redsui {
    struct REDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDSUI>(arg0, 6, b"REDSUI", b"RED SUI", b"Its sui Token but in red", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735391892341.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

