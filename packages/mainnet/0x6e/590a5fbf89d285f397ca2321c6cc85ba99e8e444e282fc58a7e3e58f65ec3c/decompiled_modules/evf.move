module 0x6e590a5fbf89d285f397ca2321c6cc85ba99e8e444e282fc58a7e3e58f65ec3c::evf {
    struct EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVF>(arg0, 6, b"EVF", b"EVOFROG", x"f09d97a0f09d97b2f09d97b2f09d98812045766f46726f6720496e7370697265642062792074686520657069632065766f6c7574696f6e206f662046726f616b696520746f204772656e696e6a61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifaqyz7cv2riwui75gohewyxgjspgpog4p2jfszu6f7eyxyt5c5zu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

