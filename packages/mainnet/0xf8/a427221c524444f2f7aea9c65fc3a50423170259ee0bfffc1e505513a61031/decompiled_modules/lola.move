module 0xf8a427221c524444f2f7aea9c65fc3a50423170259ee0bfffc1e505513a61031::lola {
    struct LOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLA>(arg0, 6, b"LOLA", b"Lola on Sui", b"Lola is here to clean the mess", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/190108144_306220441059181_2063770929823882151_n_02977397e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

