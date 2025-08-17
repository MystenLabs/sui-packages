module 0xf48a6eb9d730d20a1ac833ea0b52c7f917e6beb87f9d3e72d96e74354c3763bd::TC {
    struct TC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TC>(arg0, 6, b"Trench Cat", b"TC", b"Trench Cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreibwkj6kpimfu42s3h5ahewcgyfpr25zul5nemulls2mdaj5gb6vke")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TC>>(v0, @0x29fae3773ef0772759eac0d4c7b3d67813b0dc64f5a4c7a4d6d3c39a55a66dec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TC>>(v1);
    }

    // decompiled from Move bytecode v6
}

