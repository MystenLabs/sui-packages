module 0x8e902f3f18fbea0fde716135c51c9e62e349b88d9367ca094fc71804fea46b51::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"Mojo Sui", x"4d4f4a4f20697320686572650a41206c6567656e646172792063686172616374657220696e737069726564206279204d617474204675726965277320666972737420696c6c757374726174696f6e2c20636170747572696e672068697320756e697175652068756d6f7220616e64207375727265616c20766973696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045220_4382373293.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

