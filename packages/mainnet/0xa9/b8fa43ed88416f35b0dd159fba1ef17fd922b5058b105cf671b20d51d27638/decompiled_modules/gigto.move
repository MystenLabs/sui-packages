module 0xa9b8fa43ed88416f35b0dd159fba1ef17fd922b5058b105cf671b20d51d27638::gigto {
    struct GIGTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGTO>(arg0, 6, b"GIGTO", b"GigTools", b"GigTools revolution of SUI DeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictdm6aaca4citsmjeiz4uwu6z25fa4zcyallirqzc3dagh5piila")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GIGTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

