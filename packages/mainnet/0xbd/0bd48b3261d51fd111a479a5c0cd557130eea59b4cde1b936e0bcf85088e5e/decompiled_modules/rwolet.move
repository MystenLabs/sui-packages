module 0xbd0bd48b3261d51fd111a479a5c0cd557130eea59b4cde1b936e0bcf85088e5e::rwolet {
    struct RWOLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWOLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWOLET>(arg0, 6, b"RWOLET", b"ROWLET SUI", x"526f776c6574206973206120736d616c6c2c20617669616e20506f6bc3a96d6f6e20726573656d626c696e67206120796f756e67206f776c2077697468206120726f756e6420626f647920616e642073686f7274206c6567732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigfgw66q622yyz5hydhgkoxsiy5nztua6sixazmfeozewbwb65cre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWOLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RWOLET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

