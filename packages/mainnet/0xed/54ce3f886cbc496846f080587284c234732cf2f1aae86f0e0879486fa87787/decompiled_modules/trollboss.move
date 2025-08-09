module 0xed54ce3f886cbc496846f080587284c234732cf2f1aae86f0e0879486fa87787::trollboss {
    struct TROLLBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLBOSS>(arg0, 6, b"TROLLBOSS", b"Troll Boss", b"Troll Boss is the final Boss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6o72cvw5vzhb6geo55qtidjci763d6ajsa7xzby2aiysyvojbwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLBOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TROLLBOSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

