module 0x8ac046614977d34e14c53a8b8c55d1fd3238f875f70345b60d2ca268b53eda50::chud {
    struct CHUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUD>(arg0, 6, b"Chud", b"Chudjak", b"Billions must buy, SUIIIIIIIIII!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chudak_f2651cc83e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

