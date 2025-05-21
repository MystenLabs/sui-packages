module 0x85d22aa026880b12292423efa877703a465e3a729f1a879fdce8ac9e74592879::suitalian {
    struct SUITALIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITALIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITALIAN>(arg0, 6, b"SUITALIAN", b"Suitalian Rose", b"Suitalian, a Red Rose of Appreciation for those on SUI Blockchain, this Italian Red Rose symbolizes being a friend and loving one another, send a $SUITALIAN Rose to a friend, a lover, your family, it doesn't matter, that's the use-case! LOVE! <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747811380126.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITALIAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITALIAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

