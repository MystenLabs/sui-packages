module 0xb0033ca56688ab6e775791a9e0047586168dcf225658cd1eda35e82e4a750dcb::rowlet {
    struct ROWLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROWLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROWLET>(arg0, 6, b"ROWLET", b"Rowlet Sui", x"526f776c6574206973206120736d616c6c2c20617669616e20506f6bc3a96d6f6e20726573656d626c696e67206120796f756e67206f776c2077697468206120726f756e6420626f647920616e642073686f7274206c6567732e2049747320706c756d616765206973207072696d6172696c792062656967652077697468206120776869746520756e6465727369646520616e642066616369616c20646973632e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigfgw66q622yyz5hydhgkoxsiy5nztua6sixazmfeozewbwb65cre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROWLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROWLET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

