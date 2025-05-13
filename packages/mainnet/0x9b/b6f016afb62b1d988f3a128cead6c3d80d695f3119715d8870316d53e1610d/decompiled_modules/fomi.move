module 0x9bb6f016afb62b1d988f3a128cead6c3d80d695f3119715d8870316d53e1610d::fomi {
    struct FOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMI>(arg0, 6, b"FOMI", b"Fomoki on sui", x"464f4d4f6b692069732061206d697363686965766f75732c0a636f6d6d756e6974792d64726976656e206d656d65636f696e0a6275696c74206f6e207468652053554920626c6f636b636861696e2c0a64657369676e656420746f206675656c206578636974656d656e7420616e640a464f4d4f207769746820737572707269736520726577617264730a616e64206275726e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000090812_0a904a48eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

