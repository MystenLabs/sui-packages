module 0x91ae37b064c7a9a0d6f79123e7c44508181bdf1d53857aa2c593b9e178e8042::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOT>(arg0, 9, b"BOT", b"BOT", b"HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/ICdyLH5_IBgPf3Mh?width=400&height=400&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOT>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

