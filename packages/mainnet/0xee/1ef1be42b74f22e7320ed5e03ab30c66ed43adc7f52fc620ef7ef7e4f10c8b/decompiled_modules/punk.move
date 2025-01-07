module 0xee1ef1be42b74f22e7320ed5e03ab30c66ed43adc7f52fc620ef7ef7e4f10c8b::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 9, b"PUNK", b"SuiPunks", b"Airdropping 10,000 Punks To The Sui Community & Holders Of $PUNK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FA85_CFE_6_E_4671_4_DFA_85_F9_DA_8_CAB_2_BB_8_A1_ddf696328b.jpeg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUNK>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

