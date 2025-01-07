module 0x6426a1ba36cafcc16ee44afc0600180d2f2e030bca87bc3da70891da4ed4a685::onlyfrenz {
    struct ONLYFRENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYFRENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYFRENZ>(arg0, 6, b"OnlyFrenz", b"OnlyFrenzzz", b"We will influence the influencers to promote for us - Oh how the turns have tabled", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0095_3583d175ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYFRENZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONLYFRENZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

