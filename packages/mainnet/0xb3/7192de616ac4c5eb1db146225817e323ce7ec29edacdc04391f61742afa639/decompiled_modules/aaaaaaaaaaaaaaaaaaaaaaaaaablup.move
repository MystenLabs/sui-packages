module 0xb37192de616ac4c5eb1db146225817e323ce7ec29edacdc04391f61742afa639::aaaaaaaaaaaaaaaaaaaaaaaaaablup {
    struct AAAAAAAAAAAAAAAAAAAAAAAAAABLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAAAAAAAAAAAAAAAAAAABLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAAAAAAAAAAAAAAAAAAAAAABLUP>(arg0, 6, b"AAAaaaaaaaaaaaaaaaaaaaaaaaBLUP", b"AAAaaaaaaaaaaaaaaaaaaaaaaa BLUP", x"414141616161616161616161616161616161616161616161616120424c555020596f7572206c617374206368616e63650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_08_105712_e718d8af1b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAAAAAAAAAAAAAAAAAAAAAABLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAAAAAAAAAAAAAAAAAAAAAABLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

