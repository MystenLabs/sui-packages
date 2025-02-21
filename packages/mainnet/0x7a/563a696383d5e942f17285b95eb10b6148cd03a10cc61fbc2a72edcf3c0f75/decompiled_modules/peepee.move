module 0x7a563a696383d5e942f17285b95eb10b6148cd03a10cc61fbc2a72edcf3c0f75::peepee {
    struct PEEPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPEE>(arg0, 9, b"PEEPEE", b"peepee", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeWJZtdaoQsjhSSxcc5LKbgWPuBjXc9oNxgDs19dBmaXE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEEPEE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEEPEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

