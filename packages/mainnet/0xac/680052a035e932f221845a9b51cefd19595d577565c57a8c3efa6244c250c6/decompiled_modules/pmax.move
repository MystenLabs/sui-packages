module 0xac680052a035e932f221845a9b51cefd19595d577565c57a8c3efa6244c250c6::pmax {
    struct PMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMAX>(arg0, 6, b"PMAX", b"Penguinnis Maximus", b"With the ashes of a burning Athens behind him.  Lord Penguinnis looks to lay seige upon his next conquest !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734918695743.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PMAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

