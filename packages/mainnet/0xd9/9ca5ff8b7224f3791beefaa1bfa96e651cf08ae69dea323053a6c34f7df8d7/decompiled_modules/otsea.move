module 0xd99ca5ff8b7224f3791beefaa1bfa96e651cf08ae69dea323053a6c34f7df8d7::otsea {
    struct OTSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTSEA>(arg0, 6, b"OTSEA", b"OTSEA SUI", x"4772656574696e67732077656c636f6d6520746f204f545365612c20546865206c656164696e6720503250204f544320506c6174666f726d21200a0a4e6f7720776974682066726565206c6971756964697479206c6f636b696e6720616e642061206c6f636b206d61726b6574706c6163650a0a446f6e7420666f7267657420746f20636865636b20746865206c696e6b732062656c6f772c20616e64206f6620636f757273652c2073686f756c6420796f75206e65656420616e792068656c70206f7572207472757374792063726577206973206865726520746f20677569646520796f752e2041686f792120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6486_9a46143f4d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTSEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

