module 0x2042f5621c8ffd66eb24148df9d02c9f20acedf5c5f2c4436c10b634b49b672a::cmb {
    struct CMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMB>(arg0, 6, b"CMB", b"charles montgomery burns", b"Charles Montgomery Burns was the second-youngest of 12 children, and he was such a cheerful and amiable kid that his parents called him Happy. It all changed when he left his family to live with a twisted and heartless billionaire, who turned out to be his grandfather and former slaveholder Colonel Wainwright Montgomery Burns  and this made way for one explanation on how Mr. Burns became so rich, as he inherited his grandfathers wealth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dgyn1ut_8b2c8612_3398_413a_8ed2_435c5dfe331d_010bdefb61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

