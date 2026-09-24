module 0x4c06ee518a9450ca508fd553e227f509c936b3142f299e66e0038e0c6fb5e8e::moj {
    struct MOJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJ>(arg0, 6, b"MOJ", b"Henohenomoheji", x"48656e6f68656e6f6d6f68656a6920e2809420436f6d6d756e69747920e280a2204d656d657320e280a22043756c7475726520e280a22046756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1790258284031.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

