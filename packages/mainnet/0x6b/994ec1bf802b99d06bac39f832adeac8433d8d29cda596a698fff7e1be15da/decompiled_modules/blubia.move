module 0x6b994ec1bf802b99d06bac39f832adeac8433d8d29cda596a698fff7e1be15da::blubia {
    struct BLUBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBIA>(arg0, 6, b"BLUBIA", b"Blubia Blub's Girlfriend", x"4d6565742024424c55424941206f6e6520616e64206f6e6c79206769726c667269656e64206f662024424c55422e0a53686527732073617373792c206c6f79616c2061206c6974746c6520756e68696e67656420616e6420746f7474616c6c7920737465616c696e67207468652073706f746c696768742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiawejsk3cs72ptz5hhhukij3y3t3qvyd6j6722uxj4g7loz4v2wrq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUBIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

