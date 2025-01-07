module 0x685f81c8f037238b5aa4446bef3ac4017236ef06692c7cf59b8c129351ee9900::locos {
    struct LOCOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCOS>(arg0, 6, b"LOCOs", b"LocoWifCoco", b"maker of memes, maker of moves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007376445.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOCOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

