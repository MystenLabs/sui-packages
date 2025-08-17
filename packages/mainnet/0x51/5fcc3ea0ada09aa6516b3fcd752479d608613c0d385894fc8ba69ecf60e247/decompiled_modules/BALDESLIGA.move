module 0x515fcc3ea0ada09aa6516b3fcd752479d608613c0d385894fc8ba69ecf60e247::BALDESLIGA {
    struct BALDESLIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDESLIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDESLIGA>(arg0, 6, b"Baldies", b"Baldesliga", x"574147424920e28093205765e28099726520416c6c20476f6e6e612042616c6420496e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreidnbyjzhonidl4czgmj3symwgbtr3w7mvvnm7hhji3zpvawo3dfnu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDESLIGA>>(v0, @0x4888d9d2d81d2451e6fb78c071f6a7514a2bb126fcae8d5f3d296f8b68b140b4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALDESLIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

