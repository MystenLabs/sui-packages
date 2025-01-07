module 0xdc221d8ab0dffbc975f8fc74fe34daef23654a749d9b0d061d52da171201e5bc::r {
    struct R has drop {
        dummy_field: bool,
    }

    fun init(arg0: R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R>(arg0, 6, b"R", b"Red Frog On Sui", b"Don't buy. It's scam.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950446199.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

