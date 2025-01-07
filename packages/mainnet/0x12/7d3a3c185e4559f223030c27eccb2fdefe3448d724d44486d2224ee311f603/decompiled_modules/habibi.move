module 0x127d3a3c185e4559f223030c27eccb2fdefe3448d724d44486d2224ee311f603::habibi {
    struct HABIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABIBI>(arg0, 6, b"HABIBI", b"HABIBISUI", b"OIL MEETS CURRENCY IN CRYPTO PLANET !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HABIBI_895e70fcc5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HABIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

