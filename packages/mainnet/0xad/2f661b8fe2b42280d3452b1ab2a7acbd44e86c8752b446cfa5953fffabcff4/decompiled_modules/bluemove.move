module 0xad2f661b8fe2b42280d3452b1ab2a7acbd44e86c8752b446cfa5953fffabcff4::bluemove {
    struct BLUEMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEMOVE>(arg0, 9, b"BLUEMOVE", b"BlueMove", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/28917/large/BlueMoveCoin.png?1696527892")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEMOVE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEMOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

