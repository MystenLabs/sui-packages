module 0xc26ebc9837c9b5068af912f065ffde06482e9f94bc19c147b9986673fc1d762::s2 {
    struct S2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S2>(arg0, 6, b"S2", b"S2", b"sleep2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicb73yc7w7mzfkwbvszkwd7x2ublqm3q6muzgwycs5uflimldmhay")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<S2>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S2>>(v2, @0x45c5b4a44b7f0411b661b677d2816d04c972d8fc4a0c79ca83dc10cc4827d5fe);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S2>>(v1);
    }

    // decompiled from Move bytecode v6
}

