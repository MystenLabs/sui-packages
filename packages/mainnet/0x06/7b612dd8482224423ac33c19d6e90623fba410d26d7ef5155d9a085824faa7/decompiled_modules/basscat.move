module 0x67b612dd8482224423ac33c19d6e90623fba410d26d7ef5155d9a085824faa7::basscat {
    struct BASSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASSCAT>(arg0, 6, b"BASSCAT", b"BASS CAT", b"https://www.youtube.com/watch?v=rQxL3ejPb5c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/webp_image_222x222_66e4565f87fa4_6d163a2196.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

