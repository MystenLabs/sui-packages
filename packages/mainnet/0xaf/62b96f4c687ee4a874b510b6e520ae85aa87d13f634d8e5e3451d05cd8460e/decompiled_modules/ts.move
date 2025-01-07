module 0xaf62b96f4c687ee4a874b510b6e520ae85aa87d13f634d8e5e3451d05cd8460e::ts {
    struct TS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TS>(arg0, 6, b"TS", b"TokenSuite", b"TokenSuite excels in defining and executing go-to market strategy, with the ability to build, launch, and market your product.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734753403781.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

