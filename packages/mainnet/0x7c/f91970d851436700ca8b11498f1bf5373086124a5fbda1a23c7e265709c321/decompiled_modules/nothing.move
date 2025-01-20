module 0x7cf91970d851436700ca8b11498f1bf5373086124a5fbda1a23c7e265709c321::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTHING>(arg0, 8, b"Nothing", b"Should be nothings", b"Nothing should be here ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/18ff5ce0-d732-11ef-a70f-556b339362b9")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTHING>>(v1);
        0x2::coin::mint_and_transfer<NOTHING>(&mut v2, 110000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

