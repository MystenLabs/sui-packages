module 0x55288ca23b42dec45a9eea1e42c331d42732f766f83c2da70908fbc670f7e13e::catdog {
    struct CATDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDOG>(arg0, 6, b"CATDOG", b"CatDog 0n Sui", x"434154444f470a40436174446f675f4f4e535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0sm_G68aq_400x400_fbf94492da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

