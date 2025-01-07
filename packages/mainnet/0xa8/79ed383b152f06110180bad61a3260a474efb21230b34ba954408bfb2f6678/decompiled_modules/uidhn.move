module 0xa879ed383b152f06110180bad61a3260a474efb21230b34ba954408bfb2f6678::uidhn {
    struct UIDHN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UIDHN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UIDHN>(arg0, 6, b"UIDHN", b"hdc skh", b"suicbskdb jubiub hbuv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_removebg_preview_4_79a870f94b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UIDHN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UIDHN>>(v1);
    }

    // decompiled from Move bytecode v6
}

