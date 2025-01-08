module 0x5cf5fa286fff219617538da1b684a1b491b8f6fe139b7405a2c9d5200206940e::shartcoin {
    struct SHARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARTCOIN>(arg0, 9, b"SHARTCOIN", b"Shartcoin", b"Tokenising Sharts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRMHcqTdiKHAktRJpzer3siFgmRBVNGEspMBYdpWRxasW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHARTCOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARTCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

