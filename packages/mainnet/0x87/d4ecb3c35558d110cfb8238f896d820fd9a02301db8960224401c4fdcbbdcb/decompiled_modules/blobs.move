module 0x87d4ecb3c35558d110cfb8238f896d820fd9a02301db8960224401c4fdcbbdcb::blobs {
    struct BLOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBS>(arg0, 6, b"BLOBS", b"DE BLOBS", x"24426c6f6273206973206d6f7265207468616e206a7573742061206d656d65636f696e3b206974277320746865207374617274206f662061206e6577206d6f76656d656e74206f6e207468652053756920626c6f636b636861696e2e0a0a0a0a0a0a41206c6567656e646172792063686172616374657220696e737069726564206279204d617474204675726965277320666972737420696c6c757374726174696f6e2c20636170747572696e672068697320756e697175652068756d6f7220616e64207375727265616c20766973696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731427083897.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

