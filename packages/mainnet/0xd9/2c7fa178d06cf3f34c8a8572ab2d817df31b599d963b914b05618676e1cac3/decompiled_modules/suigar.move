module 0xd92c7fa178d06cf3f34c8a8572ab2d817df31b599d963b914b05618676e1cac3::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 6, b"SUIGAR", b"Suigar Saga", x"412066756e20576562332067616d65206f6e2053756920626c6f636b636861696e207769746820506f6bc3a96d6f6e2d6c696b65204e4654206372656174757265732c20636f6f6c20626174746c65732c20616e6420656173792074726164696e6720666f7220636f6c6c6563746f727320616e642067616d6572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiexmywxhisoo6mlcfkdfemz7mk2jkxmdrvlmzmk2ye5wn7w7tdyni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

