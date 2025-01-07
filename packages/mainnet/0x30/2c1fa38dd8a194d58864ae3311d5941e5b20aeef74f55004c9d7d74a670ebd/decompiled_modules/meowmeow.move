module 0x302c1fa38dd8a194d58864ae3311d5941e5b20aeef74f55004c9d7d74a670ebd::meowmeow {
    struct MEOWMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWMEOW>(arg0, 6, b"MEOWMEOW", b"MEOWMEOW", b"TikTok's Biggest Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-rapid-stork-14.mypinata.cloud/ipfs/QmR5tuFR2gw8B5Ef4uSWPVa8owabT8mKx6pBYLvKAkpurg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWMEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEOWMEOW>>(0x2::coin::mint<MEOWMEOW>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEOWMEOW>>(v2);
    }

    // decompiled from Move bytecode v6
}

