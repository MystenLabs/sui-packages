module 0xdef6020b583b9c8c0894abda3ad2c7325b18e1f3b51235356dff6bd6082dd1e2::stz {
    struct STZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: STZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STZ>(arg0, 6, b"STZ", b"Suitizens", b"Suitizens is a fun, community-driven memecoin built on the Sui blockchain. With a playful and engaging theme, Suitizens aims to blend humor and decentralized finance, offering a unique, lighthearted entry into the world of cryptocurrency while leveraging the speed and scalability of the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/suitizens_db2e3e13a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

