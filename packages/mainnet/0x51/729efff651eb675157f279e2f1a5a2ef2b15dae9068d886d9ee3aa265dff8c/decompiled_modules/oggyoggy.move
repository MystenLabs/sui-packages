module 0x51729efff651eb675157f279e2f1a5a2ef2b15dae9068d886d9ee3aa265dff8c::oggyoggy {
    struct OGGYOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGYOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGYOGGY>(arg0, 6, b"OggyOggy", b"Oggy Oggy on sui", b"Let's discover the secrets about Oggy Oggy together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_31_23_43_03_ba62f50df1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGYOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGYOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

