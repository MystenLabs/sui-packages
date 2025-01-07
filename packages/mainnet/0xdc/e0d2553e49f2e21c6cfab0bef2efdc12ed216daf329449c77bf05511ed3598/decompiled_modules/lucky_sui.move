module 0xdce0d2553e49f2e21c6cfab0bef2efdc12ed216daf329449c77bf05511ed3598::lucky_sui {
    struct LUCKY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY_SUI>(arg0, 9, b"LUCKY SUI", x"f09f8d804c75636b79537569", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUCKY_SUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKY_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

