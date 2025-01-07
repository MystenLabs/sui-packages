module 0xd745a3c77a240a53b18b4b3a1a59efc941f56d492e2cdb3e77749fc585f3dec7::uscat {
    struct USCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USCAT>(arg0, 6, b"USCAT", b"USA Cat", x"555341204361742070726f756420746f20626520416d65726963616e0a43656c6562726174696e672063617420616e642074686520556e6974656420537461746573206f6620416d65726963610a68747470733a2f2f742e6d652f757361636174737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003348_1223e0f8c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

