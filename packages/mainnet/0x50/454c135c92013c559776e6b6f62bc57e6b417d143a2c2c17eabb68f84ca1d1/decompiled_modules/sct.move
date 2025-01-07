module 0x50454c135c92013c559776e6b6f62bc57e6b417d143a2c2c17eabb68f84ca1d1::sct {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCT>(arg0, 6, b"SCT", b"Sui cat", b"Sui cat is the cutest sui chain cat coin and will develop into the best cat meme coin. For cat lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1289_fd72bbe3ef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

