module 0x9935ca5ca3a1dd0f9d8e4f2ad2dd2c7f6ae3f03b929d50985ed9de04f2dcacb0::suly {
    struct SULY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULY>(arg0, 6, b"SULY", b"SULY on Sui", x"4e6576657220657665722073746f70206265696e6720637574650a0a782e636f6d2f53554c594f4e5355490a0a742e6d652f53554c59535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_11_17_44_23_3_f3eec11af4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULY>>(v1);
    }

    // decompiled from Move bytecode v6
}

