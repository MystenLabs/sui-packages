module 0x72251e2e99d1139f77fa0132275cc957ef3203d47f8c3dce2a232898f3daff46::fog {
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

