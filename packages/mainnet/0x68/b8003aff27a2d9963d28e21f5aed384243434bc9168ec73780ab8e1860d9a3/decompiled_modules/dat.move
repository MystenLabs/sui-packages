module 0x68b8003aff27a2d9963d28e21f5aed384243434bc9168ec73780ab8e1860d9a3::dat {
    struct DAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAT>(arg0, 6, b"DAT", b"Adidthat", b"#ADIDTHAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0803_48934f01e5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

