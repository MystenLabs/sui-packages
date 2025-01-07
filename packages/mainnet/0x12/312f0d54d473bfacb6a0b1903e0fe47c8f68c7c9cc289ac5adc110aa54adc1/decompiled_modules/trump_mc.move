module 0x12312f0d54d473bfacb6a0b1903e0fe47c8f68c7c9cc289ac5adc110aa54adc1::trump_mc {
    struct TRUMP_MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_MC>(arg0, 9, b"TRUMP MC", b"TRUMP MC", b"TRUMP MC WIN ! KAMALA HARIS YOU LOST !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.dailymail.co.uk/1s/2024/10/16/03/90901051-13964329-Donald_Trump_eating_McDonald_s_on_his_plane_It_appears_he_ordere-a-8_1729044085355.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP_MC>(&mut v2, 15000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP_MC>>(v2, @0xde66d0f769cce0c0d5a1caf56196bde824334efc87dba799bc1d40e4701a7148);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP_MC>>(v1);
    }

    // decompiled from Move bytecode v6
}

