module 0xaaa0bce7f24380633dc4fd09964e67ebf9bd810583b62b11571b4f93cba0a80f::ioar {
    struct IOAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOAR>(arg0, 6, b"IOAR", b"Inu On A Rug", b"Just a dog on a rug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241009_160055_Gallery_1cbdfcff4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

