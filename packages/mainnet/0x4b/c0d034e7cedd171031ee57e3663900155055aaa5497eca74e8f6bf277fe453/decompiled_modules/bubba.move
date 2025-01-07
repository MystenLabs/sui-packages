module 0x4bc0d034e7cedd171031ee57e3663900155055aaa5497eca74e8f6bf277fe453::bubba {
    struct BUBBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBA>(arg0, 6, b"Bubba", b"Bubba On Sui", b"Yo! My names Bubba, and Ive been having a blast on this holiday! Sun, sand, and all the banana smoothies you can drinkextra rum, of course! Join me for some wild adventures! Well hit the beach, party and maybe even have a freak off with the cute orangutans at the tiki bar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_28_at_15_26_43_c9ea9c406a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

