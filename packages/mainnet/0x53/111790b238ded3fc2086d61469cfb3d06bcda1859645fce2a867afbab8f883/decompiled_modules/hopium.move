module 0x53111790b238ded3fc2086d61469cfb3d06bcda1859645fce2a867afbab8f883::hopium {
    struct HOPIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPIUM>(arg0, 6, b"HOPIUM", b"HOPI ON SUI", b"The hilariously clueless hippo who always gets into ridiculous jungle mishaps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_193421_cef02b91c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPIUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPIUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

