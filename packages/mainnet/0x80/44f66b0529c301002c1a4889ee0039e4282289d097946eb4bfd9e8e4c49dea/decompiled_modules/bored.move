module 0x8044f66b0529c301002c1a4889ee0039e4282289d097946eb4bfd9e8e4c49dea::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED>(arg0, 6, b"BORED", b"Bored Boyz Club", x"426f72656420426f797a2077617320626f726e20647572696e67206f6e65206f662074686f7365206c6f6e67206d61726b6574206c756c6c732e2045766572796f6e65206a7573742073746172696e67206174206368617274732c2077616974696e6720666f7220746865206e65787420626967207468696e672e0a536f207765206465636964656420746f2073746f702077616974696e6720616e64206d616b65206974206f757273656c7665732e2024424f524544206973206120636f696e20666f7220746865207265616c206f6e65732c2074686520626f7265642c207468652062726176652c2074686520626f797a2028616e64206769726c7a292e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicdjonx4qaap5iqakgs3bgcypi7bemgz5k3clkdke2cqms3m3qnaq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

