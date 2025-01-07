module 0x30e171331d9c306b09e690703acef7bdbddd505fd7552bb18feb2bb89376bd95::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"ORCA", b"Rudy the orca", b"rudy the orca was just an ordinary man until he bought $ORCA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988619953.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

