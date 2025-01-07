module 0xc8918d9f8e5a0818f946ee47162c1dba5f74a3e3e7fda98c87c88c78eaaae833::ornn_token {
    struct ORNN_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ORNN_TOKEN>, arg1: 0x2::coin::Coin<ORNN_TOKEN>) {
        0x2::coin::burn<ORNN_TOKEN>(arg0, arg1);
    }

    fun init(arg0: ORNN_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORNN_TOKEN>(arg0, 9, b"ORNN", b"ornn", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeigxdcbuu2vmd2mwh6j5bmme2sjcby47uyeolsu724feoptmpb73ai.ipfs.w3s.link/ornn_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORNN_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORNN_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ORNN_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ORNN_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

