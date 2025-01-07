module 0x7d2ad6ef832f8377d20e5fb8abef012f7505fc29fb0201840d6b2e5bc7d78d32::susan {
    struct SUSAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSAN>(arg0, 6, b"SUSAN", b"Susan", b"every time the timer hits zero a new trick will be released. stealth launch. susan will escape shortly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/444_e8d937b04f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

