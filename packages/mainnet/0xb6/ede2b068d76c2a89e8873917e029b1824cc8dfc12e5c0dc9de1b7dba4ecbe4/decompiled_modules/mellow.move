module 0xb6ede2b068d76c2a89e8873917e029b1824cc8dfc12e5c0dc9de1b7dba4ecbe4::mellow {
    struct MELLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELLOW>(arg0, 9, b"MELLOW", b"MELLOW MAN by Matt Furie", b"Mellow Man is the most famous HEDZ character who is a friend of Pepe, Brett, and the rest of the Boys Club gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR8NL1JHPqU2Cgmj6LvR52yxkLhoGTebpsCkyjRoV5EzJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MELLOW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELLOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELLOW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

