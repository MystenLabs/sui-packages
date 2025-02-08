module 0x9528abfc5ba96b4073d8772da6629042c299d4dbe47a331ead3f3c02cd838bc7::octop {
    struct OCTOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOP>(arg0, 6, b"OCTOP", b"OCTOPS ON SUI", b"Dive into the Future with Octupos Coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739017742886.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

