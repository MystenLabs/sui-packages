module 0xfd276feb646c4c1cc4c328b31c8d0e3531831a12d49e5e3989ab02a8ba29b8dc::b_aaa {
    struct B_AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_AAA>(arg0, 9, b"bAAA", b"bToken AAA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_AAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_AAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

