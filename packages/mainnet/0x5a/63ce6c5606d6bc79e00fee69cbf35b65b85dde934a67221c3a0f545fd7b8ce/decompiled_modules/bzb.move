module 0x5a63ce6c5606d6bc79e00fee69cbf35b65b85dde934a67221c3a0f545fd7b8ce::bzb {
    struct BZB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZB>(arg0, 6, b"BZB", b"banana zone believer", b"we are the banana zone believers, it will come very soon, pump our bags and unfuck our future!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749760677043.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BZB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

