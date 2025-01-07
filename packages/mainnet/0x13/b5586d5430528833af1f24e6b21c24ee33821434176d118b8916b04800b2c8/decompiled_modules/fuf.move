module 0x13b5586d5430528833af1f24e6b21c24ee33821434176d118b8916b04800b2c8::fuf {
    struct FUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUF>(arg0, 6, b"FUF", b"SUIFU", b"gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_18_23_09_60613e40be_231d99e8d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

