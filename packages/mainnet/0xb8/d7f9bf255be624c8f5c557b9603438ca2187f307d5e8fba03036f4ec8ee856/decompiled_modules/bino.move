module 0xb8d7f9bf255be624c8f5c557b9603438ca2187f307d5e8fba03036f4ec8ee856::bino {
    struct BINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINO>(arg0, 6, b"Bino", b"BINOSAURUS", x"2442696e6f206973206e6f74206a75737420616e6f746865722063727970746f63757272656e63793b2069742773206120636f6d706c6574652065636f73797374656d2064657369676e656420746f20706f7765722074686520667574757265206f6620646563656e7472616c697a65642066696e616e63652e204275696c74206f6e2063757474696e672d6564676520626c6f636b636861696e20746563686e6f6c6f67792c2042494e4f206f666665727320756e706172616c6c656c65642073656375726974792c2073706565642c20616e64207363616c6162696c6974792e0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345cbb_e6b1c284e029475baaaf070fa3552a20_mv2_b99496ef38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

