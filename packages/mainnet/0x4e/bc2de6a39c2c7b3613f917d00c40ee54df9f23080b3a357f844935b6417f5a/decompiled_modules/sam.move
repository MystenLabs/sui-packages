module 0x4ebc2de6a39c2c7b3613f917d00c40ee54df9f23080b3a357f844935b6417f5a::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 9, b"Sam", b"Sam", b"Sam. Chiken's egg.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/jpeg;base64,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")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAM>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

