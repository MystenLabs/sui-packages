module 0xe7f789ff00467e77982b77cb056ea1aabf3852df1c92420d2c4d651657a6a1ca::grumpy {
    struct GRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPY>(arg0, 9, b"grumpy", b"Grumpy Gruss", b"A Krampus doodle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/users/5638/screenshots/17058315/media/2a8ee60b275ebb5343167b3d190adb41.jpg?resize=800x600&vertical=center")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRUMPY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

