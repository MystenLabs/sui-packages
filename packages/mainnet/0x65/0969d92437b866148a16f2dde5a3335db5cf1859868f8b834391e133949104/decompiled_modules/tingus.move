module 0x650969d92437b866148a16f2dde5a3335db5cf1859868f8b834391e133949104::tingus {
    struct TINGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINGUS>(arg0, 9, b"TINGUS", b"TINGUS on SUI", b"I make strange stuff.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf8iHPBry3nEFh4SxMCwmRMAqAeDv4nC11tzLaAsfdhVg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TINGUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINGUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINGUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

