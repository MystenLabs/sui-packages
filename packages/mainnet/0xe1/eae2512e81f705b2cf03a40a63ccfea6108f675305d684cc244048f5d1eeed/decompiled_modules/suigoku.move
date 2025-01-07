module 0xe1eae2512e81f705b2cf03a40a63ccfea6108f675305d684cc244048f5d1eeed::suigoku {
    struct SUIGOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOKU>(arg0, 6, b"SUIGOKU", b"SUI GOKU", x"24535549474f4b552c20726561647920746f2074616b6f65766572205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Group_74_9b339af508.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

