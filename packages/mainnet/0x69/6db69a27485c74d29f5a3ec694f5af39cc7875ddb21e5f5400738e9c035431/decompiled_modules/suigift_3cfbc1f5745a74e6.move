module 0x696db69a27485c74d29f5a3ec694f5af39cc7875ddb21e5f5400738e9c035431::suigift_3cfbc1f5745a74e6 {
    struct SUIGIFT_3CFBC1F5745A74E6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIFT_3CFBC1F5745A74E6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIFT_3CFBC1F5745A74E6>(arg0, 0, b"SUIGIFT", b"SUIGIFT", b"Pump-style launch token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigift.fun/api/uploads/token-icons/1788192702199-8882bcfa-c9ec-4e92-a570-bcd64cebc650.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGIFT_3CFBC1F5745A74E6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIGIFT_3CFBC1F5745A74E6>>(0x2::coin::mint<SUIGIFT_3CFBC1F5745A74E6>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIFT_3CFBC1F5745A74E6>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

