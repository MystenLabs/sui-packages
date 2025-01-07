module 0x46d2bfc697086c865d5a8fd5b90adf5bb20fb026cd0bde92ebc789eed897504b::hhhhhh {
    struct HHHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHHHHH>(arg0, 6, b"HHHHHH", b"HHH", b"H", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/donald_trump_gettyimages_687193180_2ef2ed5d94.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHHHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHHHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

