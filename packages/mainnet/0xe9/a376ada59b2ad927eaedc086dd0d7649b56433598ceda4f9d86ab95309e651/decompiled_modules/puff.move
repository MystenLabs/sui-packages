module 0xe9a376ada59b2ad927eaedc086dd0d7649b56433598ceda4f9d86ab95309e651::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"PUFFER", b"Legendary Puffer Puffing SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://magenta-protestant-falcon-171.mypinata.cloud/ipfs/QmSLG12pH4gd9gCB1CquA8XNbFER3BuQ4KKR62B6jdz8W6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUFF>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

