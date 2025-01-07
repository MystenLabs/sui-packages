module 0x81215aa58fe5b3bf609fb725288cb1f4bc7c979b7ad771e22693b5b52544b7b3::bosui {
    struct BOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSUI>(arg0, 6, b"Bosui", b"Book of SUI", b"The Holy Book of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sfdfsfsd_b6242f9dcc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

