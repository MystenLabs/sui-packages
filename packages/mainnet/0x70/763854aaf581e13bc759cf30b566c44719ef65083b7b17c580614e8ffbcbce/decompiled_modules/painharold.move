module 0x70763854aaf581e13bc759cf30b566c44719ef65083b7b17c580614e8ffbcbce::painharold {
    struct PAINHAROLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAINHAROLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAINHAROLD>(arg0, 6, b"PAINHAROLD", b"Pain Harold on SUI", b"Everything is ok, you just have to hide your pain! $painharold is here to make you feel a little bit better by multiplying your money! Come join #painharold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imageedit_10_5163598523_35460e2b20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAINHAROLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAINHAROLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

