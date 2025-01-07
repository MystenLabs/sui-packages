module 0x228d7a293db1386b9721c981c6956fa9bb45c9a826a3c819f7f086b81f4f52b5::smen {
    struct SMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEN>(arg0, 6, b"SMEN", b"SUIMEN", x"496620497420446f65736e2774205461737465204c696b6520245355494d454e2c2049276d204e6f7420427579696e672049742e203a330a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_04_56_07_2_b29666f893_7f16d7aaeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

