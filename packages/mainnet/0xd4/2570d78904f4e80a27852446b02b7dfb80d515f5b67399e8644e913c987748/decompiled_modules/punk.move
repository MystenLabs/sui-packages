module 0xd42570d78904f4e80a27852446b02b7dfb80d515f5b67399e8644e913c987748::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 6, b"PUNK", b"SuiPunks", b"Airdropping 10,000 Punks To The Sui Community & Holders Of $PUNK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A85_CFE_6_E_4671_4_DFA_85_F9_DA_8_CAB_2_BB_8_A1_ddf696328b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

