module 0x3e2ef377dff3d583277d96142dd33d686c9ad6dffd38c50418ffbb37165d6ec::enosu {
    struct ENOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENOSU>(arg0, 6, b"ENOSU", b"E.NOT", b"$E.NOT- Is a meme created to attract smart money to the SUI ecosystem, the avatar of this meme was created by one artist and is not subject to forgery, part of the total liquidity that will be received by the $E.NOT, meme will be directed to improving the SUI ecosystem, and the other part to charity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1436_no_bg_preview_carve_photos_1f581d72ab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

