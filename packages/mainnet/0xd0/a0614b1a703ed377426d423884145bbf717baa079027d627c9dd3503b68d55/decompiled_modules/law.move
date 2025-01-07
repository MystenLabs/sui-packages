module 0xd0a0614b1a703ed377426d423884145bbf717baa079027d627c9dd3503b68d55::law {
    struct LAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAW>(arg0, 6, b"LAW", b"Law Of Attraction", b"positive thoughts will bring positive results when applying the law of attraction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_12_08_28_26_3c31c7ddd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

