module 0xfb113f5599a4570872c71373bdc437769ed9d4b8456a3f367e11372a210526c6::car {
    struct CAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAR>(arg0, 9, b"Car", b"Car", b"Car car car", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAR>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAR>>(v2, @0xf16666d0ec949f88bc113eca7575f8d7171574600b6f3b635a41dcb06d182ff8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

