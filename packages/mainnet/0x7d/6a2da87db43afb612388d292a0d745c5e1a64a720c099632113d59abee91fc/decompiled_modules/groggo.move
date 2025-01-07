module 0x7d6a2da87db43afb612388d292a0d745c5e1a64a720c099632113d59abee91fc::groggo {
    struct GROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGO>(arg0, 6, b"GROGGO", b"GROGO", b"Safe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731274556689.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROGGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

