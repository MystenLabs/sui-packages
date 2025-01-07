module 0x6fdef4ffff379635d6eadfa938511e4baa204167bfeeb8c0724f421de24baedb::rai {
    struct RAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAI>(arg0, 6, b"RAI", b"Rabbit AI", b"Rabbit mobile gaming has an experienced team of mobile game developers. Team tokens 50% marketing 25% burn 25% team.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5969_e2e53349c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

