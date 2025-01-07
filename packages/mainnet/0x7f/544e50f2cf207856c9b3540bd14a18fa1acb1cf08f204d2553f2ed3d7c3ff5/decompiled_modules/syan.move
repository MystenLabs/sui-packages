module 0x7f544e50f2cf207856c9b3540bd14a18fa1acb1cf08f204d2553f2ed3d7c3ff5::syan {
    struct SYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYAN>(arg0, 6, b"SYAN", b"SUIYAN", b"SUIYAN CYCLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730995703665.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

