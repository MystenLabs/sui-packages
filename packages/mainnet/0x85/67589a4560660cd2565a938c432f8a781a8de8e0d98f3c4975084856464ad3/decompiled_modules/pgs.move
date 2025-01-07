module 0x8567589a4560660cd2565a938c432f8a781a8de8e0d98f3c4975084856464ad3::pgs {
    struct PGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGS>(arg0, 6, b"PGS", b"Plush Gorilla Sofa", b"Brown Plush Gorilla Sofa ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000116896_7718a74b89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

