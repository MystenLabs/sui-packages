module 0x6d006fbca029fc297e727707256b44ad9df3bd12ea424f0d630b4d4489ce61e3::glaceon {
    struct GLACEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLACEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLACEON>(arg0, 6, b"GLACEON", b"GLACEON SUI", x"4469766520696e746f2074686520646570746873206f66206f70706f7274756e69747920776974682024476c6163656f6e2e20546865206d6f73742062656175746966756c20506f6bc3a96d6f6e20657665722c20612073796d626f6c206f6620656c6567616e63652c20616e64207765616c74682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicmecva74ifsl6df7a3rwp2324vfn45rhoa77raibak4n6xzdgury")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLACEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLACEON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

