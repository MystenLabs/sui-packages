module 0xfa41b939e3b00718fd0d7ad1816c74eeda367ae7c7b63e3d9901606c26c4d282::jeet {
    struct JEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEET>(arg0, 9, b"JEET", b"JEET", b"Hello ser do you have any marketing plan? I want a 2x on my rupees", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1650698399673458688/oC8jLZAF_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JEET>(&mut v2, 8008580085000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

