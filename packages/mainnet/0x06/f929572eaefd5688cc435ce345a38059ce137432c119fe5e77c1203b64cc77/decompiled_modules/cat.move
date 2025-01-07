module 0x6f929572eaefd5688cc435ce345a38059ce137432c119fe5e77c1203b64cc77::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"Satoshi Pawsamoto 9 LIFE", b"In the crypto jungle, one cat reigns supreme Satoshi Pawsamoto. With the agility of a predator and the wisdom of a thousand naps, this legendary cat didn't just stop at Bitcoin. He knew that cats have nine lives, and so should his currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_LIFE_cfd1727626.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

