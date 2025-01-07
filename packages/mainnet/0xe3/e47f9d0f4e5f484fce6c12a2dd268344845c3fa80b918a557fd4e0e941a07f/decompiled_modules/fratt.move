module 0xe3e47f9d0f4e5f484fce6c12a2dd268344845c3fa80b918a557fd4e0e941a07f::fratt {
    struct FRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRATT>(arg0, 6, b"FRATT", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://xatontgesaqf7cfeboedtsik7xnnz2wespeifbf3igqzifiqi6fa.arweave.net/uCbmzMSQIF-IpAuIOckK_drc6sSTyIKEu0GhlBUQR4o"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRATT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRATT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FRATT>>(v2);
    }

    // decompiled from Move bytecode v6
}

