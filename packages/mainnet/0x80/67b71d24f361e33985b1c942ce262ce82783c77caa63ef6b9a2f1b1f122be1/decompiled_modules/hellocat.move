module 0x8067b71d24f361e33985b1c942ce262ce82783c77caa63ef6b9a2f1b1f122be1::hellocat {
    struct HELLOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLOCAT>(arg0, 6, b"HelloCat", b"halloweencat", b"Very amazing halloween kitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hand_drawn_flat_halloween_cat_illustration_23_2149070335_bcf764b3b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELLOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

