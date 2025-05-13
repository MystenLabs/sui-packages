module 0x767b38881cd57267f1cc47fd514c1795e47d759842fe235fb53b1c5203c1d271::tomato {
    struct TOMATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMATO>(arg0, 6, b"TOMATO", b"TOMATO SUI", b"Round,from,juicy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibhkdwdobaaevf7di5uvixo7a725atv7nz5rwvmcyy7kir45qhnfi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOMATO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

