module 0x738830a0743a8fffd931ef159160d4136926d348d81cd2a503a4792d055d86d::s1 {
    struct S1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S1>(arg0, 6, b"S1", b"S1", b"sleep1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicb73yc7w7mzfkwbvszkwd7x2ublqm3q6muzgwycs5uflimldmhay")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<S1>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S1>>(v2, @0x45c5b4a44b7f0411b661b677d2816d04c972d8fc4a0c79ca83dc10cc4827d5fe);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S1>>(v1);
    }

    // decompiled from Move bytecode v6
}

