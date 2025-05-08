module 0x7143c8aa8df7da7c29439896ab3707b5b69d5eee2f60dacb67068b3bc511c367::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA>(arg0, 6, b"IKA", b"2PC-MPC", b"ika TGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidtccgiv3eufr2mie7rba5hdkeeet5wzb7py34cg3m73wnwpzb55y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

