module 0x9dfecb4e4f3dc7d86b9e4762b8946775c9e0be4afa0aa1e41e560f96fefe394c::t3 {
    struct T3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T3>(arg0, 6, b"T3", b"TOKEN 993", b"TOKEN 993 (T3) is a symbolic milestone token representing innovation, individuality, and the decentralized spirit of Web3. As the 993rd token to be created on the Sui Network, T3 stands as a testament to the continuous growth and evolution of the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744922364038.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

