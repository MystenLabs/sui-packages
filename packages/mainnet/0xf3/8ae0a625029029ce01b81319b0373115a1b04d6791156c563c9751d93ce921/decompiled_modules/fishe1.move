module 0xf38ae0a625029029ce01b81319b0373115a1b04d6791156c563c9751d93ce921::fishe1 {
    struct FISHE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHE1>(arg0, 6, b"FISHE1", b"FISHE", b"Fishiest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732222132386.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHE1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHE1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

