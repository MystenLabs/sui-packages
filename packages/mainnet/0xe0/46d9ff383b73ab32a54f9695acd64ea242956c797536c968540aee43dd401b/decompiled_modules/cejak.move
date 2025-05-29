module 0xe046d9ff383b73ab32a54f9695acd64ea242956c797536c968540aee43dd401b::cejak {
    struct CEJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEJAK>(arg0, 6, b"CEJAK", b"CEJAK ON SUI", b"CETUS ROBBED US! Lets send it!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7303_b77871a15f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

