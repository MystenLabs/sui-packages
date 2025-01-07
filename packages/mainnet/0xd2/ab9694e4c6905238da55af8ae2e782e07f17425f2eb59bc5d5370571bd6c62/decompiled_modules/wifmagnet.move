module 0xd2ab9694e4c6905238da55af8ae2e782e07f17425f2eb59bc5d5370571bd6c62::wifmagnet {
    struct WIFMAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFMAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFMAGNET>(arg0, 6, b"WIFMAGNET", b"DOWIF MAGNET", b"Magnet is the only thing that pull up the market in these days", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/639113_FA_BCEB_4_E12_A572_E3_C3_F8362_CAE_088fc30f72.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFMAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFMAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

