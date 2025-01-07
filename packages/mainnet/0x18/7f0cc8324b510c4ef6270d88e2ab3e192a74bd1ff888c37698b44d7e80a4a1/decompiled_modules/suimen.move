module 0x187f0cc8324b510c4ef6270d88e2ab3e192a74bd1ff888c37698b44d7e80a4a1::suimen {
    struct SUIMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEN>(arg0, 6, b"SUIMEN", b"suimen", x"496620497420446f65736e2774205461737465204c696b6520245355494d454e2c2049276d204e6f7420427579696e672049742e203a310a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_04_56_07_2_b29666f893_2cc417ba88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

