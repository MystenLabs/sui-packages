module 0x8c9edeee49057a12d11f619c8ac393196ef5dbdf2b3205ee5fe6c037e0d77654::bui {
    struct BUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUI>(arg0, 6, b"BUI", b"Bull of Sui", b"BUI on bullish SU season lets bullish!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5651_c09e1b8254.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

