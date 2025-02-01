module 0x7532567d91e4e1d163f65feed7ef5d7b9a1e0b8b5b9f6088800c574590980e34::remy {
    struct REMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMY>(arg0, 9, b"REMY", b"REMY ON SUI", b"A rat who simply adores food and its quality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTSD2H9UFY7byGjC5CwPW9Y4LWFjkW6FecXDShuQXtadM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REMY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

