module 0xd0f30179f82ecc31c5f8b97fbfe2d975e5a4973aaea42496b95b1c1c5f22c87e::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"Mojo Sui", x"4d4f4a4f20697320686572650a41206c6567656e646172792063686172616374657220696e737069726564206279204d617474204675726965277320666972737420696c6c757374726174696f6e2c20636170747572696e672068697320756e697175652068756d6f7220616e64207375727265616c20766973696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731013306074.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOJO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

