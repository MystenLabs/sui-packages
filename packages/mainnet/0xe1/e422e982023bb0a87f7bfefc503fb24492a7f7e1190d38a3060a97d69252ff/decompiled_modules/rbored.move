module 0xe1e422e982023bb0a87f7bfefc503fb24492a7f7e1190d38a3060a97d69252ff::rbored {
    struct RBORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBORED>(arg0, 6, b"RBORED", b"Bored BOYZ CLUBRelaunch", x"426f72656420426f797a2077617320626f726e20647572696e67206f6e65206f662074686f7365206c6f6e67206d61726b6574206c756c6c732065766572796f6e65206a7573742073746172696e67206174206368617274732c2077616974696e6720666f7220746865206e65787420626967207468696e672e0a536f207765206465636964656420746f2073746f702077616974696e6720616e64206d616b65206974206f757273656c7665732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicf34obkhicp4ifwhr4srzsw7clhdajppfgy46kmd6xflcanerbty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBORED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RBORED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

