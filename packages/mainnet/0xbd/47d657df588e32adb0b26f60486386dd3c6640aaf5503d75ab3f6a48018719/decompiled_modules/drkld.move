module 0xbd47d657df588e32adb0b26f60486386dd3c6640aaf5503d75ab3f6a48018719::drkld {
    struct DRKLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRKLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRKLD>(arg0, 6, b"DRKLD", b"DORKLORD | Sui", x"72657061726520796f757273656c662c20796f756e67205061646177616e2c20666f7220746865206d6f73742065706963206d656d65636f696e20696e2074686520245355492067616c6178793a20444f524b4c4f52440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SABER_c5aafbc58f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRKLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRKLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

