module 0x7aad9f18917dfc8be0466c3177c800eab17b94ab7a8cb3f8d4c4c1605059d05d::aiius {
    struct AIIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIIUS>(arg0, 6, b"AIIUS", b"AI IUS", x"41494955532069732061207820696e7465677261746564206167656e7420746861742063617272696573206f757420636f6d6d616e6420616e6420696e737472756374696f6e7320616c6c206f6e205375692065636f73797374656d0a54686572652773207468652077726974657570", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735495084072.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIIUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

