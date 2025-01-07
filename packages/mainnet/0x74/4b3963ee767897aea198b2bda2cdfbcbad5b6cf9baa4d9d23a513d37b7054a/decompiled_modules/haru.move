module 0x744b3963ee767897aea198b2bda2cdfbcbad5b6cf9baa4d9d23a513d37b7054a::haru {
    struct HARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARU>(arg0, 6, b"HARU", x"48617275206f6e20537569f09f92a7", x"4372656174696e67207468652046697273742050505020436f6d6d756e697479202620486967686573742056616c756564204d656d65636f696e202448415255206f6e2053756920f09faaa8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973474831.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

