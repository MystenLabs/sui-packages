module 0xdc117a29c02f6431ddcab431fa94fa29ca2c1d3d6e3a6b7008f4ad45f64c19f2::deal {
    struct DEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAL>(arg0, 6, b"DEAL", b"DEAL WT-ME", x"4445414c2057697468204d65204e4f5722206973206e6f74206a757374206120726f626f74e28094697427732061206d656d652063756c747572652069636f6e2064657369676e656420746f20656e7465727461696e2c20696e73706972652c20616e64206d616b6520796f75206c617567682c20616c6c207768696c652073746179696e6720756e64656e6961626c7920636f6f6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736444445833.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

