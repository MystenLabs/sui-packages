module 0x371bbd865b70b7324875d4750155591939a73347dd9d228fa83d2243d0e349a1::meowmeow {
    struct MEOWMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWMEOW>(arg0, 9, b"MEOWMEOW", b"NO.1 TIKTOK AI CAT", b"MEOWMEOW the Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmPwBVUTrt37JAtPgqnrwfPPqEyA7n4DRK1KF5MN6VKqwx?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEOWMEOW>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWMEOW>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

