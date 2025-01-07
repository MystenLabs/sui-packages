module 0x885c9360b5f9725aac940273cc075c70eec177f8d4c9bf97de905f44feb26de1::CHONG {
    struct CHONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONG>(arg0, 2, b"CHONG", b"Bitcoin Chong", b"Chong with Bitcoin what else?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/7PgYY8s2/1-XTBm-EEPgftg-PAGIWV9-VNVA.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHONG>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHONG>(&mut v2, 2100000000000, @0x1aecfa800a705446b631f2c8c58f0d7f74a6b643bb703a26f2db7c7900052c0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

