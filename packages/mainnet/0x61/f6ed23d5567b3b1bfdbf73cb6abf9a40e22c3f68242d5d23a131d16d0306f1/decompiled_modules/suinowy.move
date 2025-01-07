module 0x61f6ed23d5567b3b1bfdbf73cb6abf9a40e22c3f68242d5d23a131d16d0306f1::suinowy {
    struct SUINOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOWY>(arg0, 6, b"SUINOWY", b"SNOWY", b"Snowy DOG on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3562_b93f15e119.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

