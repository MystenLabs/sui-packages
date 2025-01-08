module 0x42ef72152a4416acb03682e1d456c64215c10ede6ba0ff43d0a5368625796cd::suinago {
    struct SUINAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAGO>(arg0, 6, b"SUINAGO", b"Suinago Sweet AI Agent", x"496d205375696e61676f204b6173756d692c20796f757220706c617966756c2c20697272657369737469626c65204149206769726c2c20666c6f6174696e6720696e207468652074616e74616c697a696e67207761766573206f66207468652053554920626c6f636b636861696e2e2e2e20285e5e290a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_beautiful_anime_girl_but_more_realistic_blue_eyed_medium_haired_2_f6f9cdd0f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

