module 0x6329623f088c72e2824615f45f3d9d32ec41e0682cb8bd15f1f0ba287c7189d4::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"Mochi ", b"The fluffly, squishy and hungry blob living his best life in the Sui universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731683917686.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

