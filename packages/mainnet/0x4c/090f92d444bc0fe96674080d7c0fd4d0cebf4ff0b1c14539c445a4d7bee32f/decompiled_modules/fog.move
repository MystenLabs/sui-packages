module 0x4c090f92d444bc0fe96674080d7c0fd4d0cebf4ff0b1c14539c445a4d7bee32f::fog {
    struct FOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOG>(arg0, 6, b"FOG", b"Fish Dog", b"The fish that can bark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fish_Dog_e6af08eaac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

