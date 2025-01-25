module 0xb2aadc37b52a85e4c42037abfb3ce3bca994cfb7efd178dafa0b511d2c0a0106::ptm {
    struct PTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTM>(arg0, 6, b"PTM", b"PHANTOM", b"Phantom making waaaves on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66030f2a_6085_4129_8555_b80de1a566a5_62d8f3d31e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

