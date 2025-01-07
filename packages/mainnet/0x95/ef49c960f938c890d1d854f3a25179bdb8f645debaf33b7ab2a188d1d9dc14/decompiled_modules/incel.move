module 0x95ef49c960f938c890d1d854f3a25179bdb8f645debaf33b7ab2a188d1d9dc14::incel {
    struct INCEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: INCEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INCEL>(arg0, 9, b"INCEL", b"InjectiveCelestiaTrump69SuiInu", b"Peak of human meme performance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-EbOP6eGwtc3WlrSlDoPmdWya?se=2023-12-15T07%3A20%3A03Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D16c002d5-e9f0-4f20-8f19-56e836fb593b.webp&sig=jiYB12qJi1zoxOihthseXNM4VF5ClWm7afhM8DQBVlw%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<INCEL>(&mut v2, 1000000001000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INCEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INCEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

