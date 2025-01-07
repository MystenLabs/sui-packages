module 0xd7f541c69f2419ceeb47c368374e339f39bfb6076326eda744e592638e76ef96::suipeople {
    struct SUIPEOPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEOPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEOPLE>(arg0, 9, b"SPeople", b"Sui People", b"Sui People", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.iconninja.com/files/553/959/655/human-hot-anonymous-user-profile-account-people-yellow-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPEOPLE>>(0x2::coin::mint<SUIPEOPLE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEOPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEOPLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

