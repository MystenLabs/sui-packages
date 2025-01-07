module 0x8ff4c279d8a61dc426363afcb8336da13f09854c8a81e7ec25ee1bcf51ce2ba5::tini {
    struct TINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINI>(arg0, 6, b"TINI", b"Suitini", b"In a realm where magic intertwines with the skies, there exists a breathtaking creature known as Suitini. This magnificent blue dragon glistens like sapphires under the radiant sun, its scales reflecting a spectrum of colors that dance in the light.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4923cdc7_04a8_4b24_b0cd_f315c7c00404_8906a0da9a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

