module 0xfc2fd1217316948faecd495bab7b0810a7d65ab48948568a3d2336449d9d4866::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"Cat", b"Cats", b"Cat in the sui summer...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_1104e6d0b4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

