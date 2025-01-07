module 0xdcb278709181c9cd6aa174623937a7d10611d3e4751097e21664114809290667::lana {
    struct LANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANA>(arg0, 9, b"LANA", b"LANA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeihspg7w6cfoejnh5qjmgpyhvnltwlswmiuyzq22baxy4xlc6vmlrm.ipfs.flk-ipfs.xyz")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LANA>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LANA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

