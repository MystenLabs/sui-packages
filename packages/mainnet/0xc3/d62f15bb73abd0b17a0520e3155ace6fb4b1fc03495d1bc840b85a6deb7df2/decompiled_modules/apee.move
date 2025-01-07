module 0xc3d62f15bb73abd0b17a0520e3155ace6fb4b1fc03495d1bc840b85a6deb7df2::apee {
    struct APEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEE>(arg0, 6, b"APEE", b"APE", b"this is ape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731006799291.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

