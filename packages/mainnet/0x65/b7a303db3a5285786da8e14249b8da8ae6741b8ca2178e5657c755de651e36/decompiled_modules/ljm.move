module 0x65b7a303db3a5285786da8e14249b8da8ae6741b8ca2178e5657c755de651e36::ljm {
    struct LJM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LJM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LJM>(arg0, 9, b"LJM", b"ConqurerLEE", b"THE NEW LEADER of REPUBLIC OF SOUTH KOREA this gonna hit the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/54dd1168fc1460db942a862920d70003blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LJM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LJM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

