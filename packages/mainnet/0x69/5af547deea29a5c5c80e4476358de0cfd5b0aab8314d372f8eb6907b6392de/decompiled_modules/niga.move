module 0x695af547deea29a5c5c80e4476358de0cfd5b0aab8314d372f8eb6907b6392de::niga {
    struct NIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGA>(arg0, 6, b"NIGA", b"Nigachu", x"49732064656469636174656420746f206669676874696e672072616369736d20616e642070726f6d6f74696e6720657175616c6974790a616d6f6e6720616c6c20726163657320626c61636b2c2077686974652c20616e642065766572796f6e6520696e6265747765656e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihl3dsmivek6drypqnj6n2rorss5ewtysred2rikl4u7lx7pitkvi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NIGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

