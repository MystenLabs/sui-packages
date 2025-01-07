module 0x88c06d94531f52f14f715331d8109a7040dba2b57d753d0eb111eb4f0c9ad194::cbs {
    struct CBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBS>(arg0, 6, b"CBS", b"CATCY-BER SUI", b"The new meta from CATCY-BER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_23_01_09_122646398e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

