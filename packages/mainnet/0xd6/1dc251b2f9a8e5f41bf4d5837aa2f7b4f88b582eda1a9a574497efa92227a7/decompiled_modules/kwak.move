module 0xd61dc251b2f9a8e5f41bf4d5837aa2f7b4f88b582eda1a9a574497efa92227a7::kwak {
    struct KWAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWAK>(arg0, 9, b"KWAK", b"Goose shouts Kwak", b"Kwak. Kwak. Kwak.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUFPkpb49LczAKq7g1vLyyLqY8Qd8A8oWgR3qRDVaHkje")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KWAK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWAK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

