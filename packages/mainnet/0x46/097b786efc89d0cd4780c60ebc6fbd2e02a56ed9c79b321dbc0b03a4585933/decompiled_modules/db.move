module 0x46097b786efc89d0cd4780c60ebc6fbd2e02a56ed9c79b321dbc0b03a4585933::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DB>(arg0, 9, b"DB", b"Dill Bits", b"Big Dill is ballin' out of control thanks to his Dill Bits crypto, which has become even more valuable than Bars*. Typically sealed behind lock and key in vaults around the Island, Dill Bits dont carry over from match to match, so spend them quickly before your wallet goes to zero! But, uh, to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNrpHP3rAq3zVVDoZ6u1mtersLdT2vgaCiuWjGPvnXfQ5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

