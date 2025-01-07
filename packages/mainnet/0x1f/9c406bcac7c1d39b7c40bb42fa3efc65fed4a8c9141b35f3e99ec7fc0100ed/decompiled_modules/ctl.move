module 0x1f9c406bcac7c1d39b7c40bb42fa3efc65fed4a8c9141b35f3e99ec7fc0100ed::ctl {
    struct CTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTL>(arg0, 6, b"CTL", b"Citadel AI", b"Our flagship product, Bare Metal servers, is designed to deliver unmatched security, flexibility, and performance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735564857353.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

