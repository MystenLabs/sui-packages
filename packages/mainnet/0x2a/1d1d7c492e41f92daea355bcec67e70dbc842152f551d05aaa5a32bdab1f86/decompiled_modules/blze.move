module 0x2a1d1d7c492e41f92daea355bcec67e70dbc842152f551d05aaa5a32bdab1f86::blze {
    struct BLZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLZE>(arg0, 6, b"BLZE", b"BLAZE the Rottweiler", b"BLAZE the ROTTWEILER has come to $SUI. $BLZE is just starting to HEAT UP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibwxtvdbsa3izpnsjldd5pftsatew3fuxoz56g4kwgrqjxs24keme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLZE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

