module 0x5dfd811c0bfdfcad8ef6d15f2e4477feddbe358b18a85d9f6be95b6f75416425::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nTEST";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dTEST";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidotfun.onrender.com/i/1kvnrjUTwy3Q0Unk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

