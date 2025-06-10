module 0xdf8c46ec246bc4788cb06544404cf862cfef298192bab87d11ef90d9f7eb9d48::koge {
    struct KOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOGE>(arg0, 6, b"KOGE", b"Kyogre", b"KYOGRE has the power to create massive rain clouds that cover the entire sky and bring about torrential downpours. This POKEMON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia3apdxrudxezpupruaqo3ers6c5g2ytff2rvwaw6rjytrolwwzy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

