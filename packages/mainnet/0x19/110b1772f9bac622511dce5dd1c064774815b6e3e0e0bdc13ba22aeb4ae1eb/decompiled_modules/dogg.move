module 0x19110b1772f9bac622511dce5dd1c064774815b6e3e0e0bdc13ba22aeb4ae1eb::dogg {
    struct DOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGG>(arg0, 6, b"DOGG", b"DOG CRIMINAL", b"THIS IS A ROBBERY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_fd6b96e0ef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

