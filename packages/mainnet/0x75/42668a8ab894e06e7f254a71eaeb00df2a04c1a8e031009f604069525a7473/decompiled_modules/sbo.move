module 0x7542668a8ab894e06e7f254a71eaeb00df2a04c1a8e031009f604069525a7473::sbo {
    struct SBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBO>(arg0, 6, b"SBO", b"Sui Box Office", x"53756920426f78204f66666963652069732053756927732076657279206669727374206368616e6e656c20746f206665617475726520666c61776c65737320616e6420686967686c7920656e7465727461696e696e672073686f77732e200a200a416e6420666f72206974277320666972737420646973683f2053657276696e6720796f7520746865206269676765737420646f78696e67206f662074686520796561722e20546865207265616c206964656e74697479206f6620537569746f7368692e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6066763600955033197_x_be38649754.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

