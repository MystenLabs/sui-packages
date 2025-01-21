module 0x1effa8ccc80c787676af70e3491b549117abedbf5f67962c701e2fd2e507e460::twh {
    struct TWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWH>(arg0, 9, b"TWH", b"Trump Wif Hat", b"Trump Wif Hat On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmd2TE4HrjchtAu3tCyUJuSxJiVc5p9FAX7xPwXaBDZEvB")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TWH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

