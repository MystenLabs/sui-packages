module 0xa3af88cc1d13981c772ca412ff2eccebe36cf6fd3761a23f1372260abc53f980::hmk {
    struct HMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMK>(arg0, 6, b"HMK", b"Honest Monkey", b"Spirit of Honesty.For a New World of the Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734269400183.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

