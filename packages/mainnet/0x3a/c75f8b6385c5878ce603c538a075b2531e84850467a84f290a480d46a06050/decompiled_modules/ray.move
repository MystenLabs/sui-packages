module 0x3ac75f8b6385c5878ce603c538a075b2531e84850467a84f290a480d46a06050::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"RAYMOONBOY", x"202020202e0a0a486573206e6f74206a75737420616e6f74686572206d656d6568657320796f7572206661766f7269746520646567656e2077697468206120647265616d2e0a52617973206f6e2061206d697373696f6e20746f206d6f6f6e2c20616e6420796f752067657420746f20706c617920697420776974682068696d2e0a0a47616d652d66697273742e204d656d652d6675656c65642e20546f6b656e2d706f77657265642e0a4c657473206d6f6f6e20746f6765746865722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250502_093829_061_19eb03fe6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

