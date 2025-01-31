module 0xb90f15d4198ed47a3b10b6420cf6f6bec318115b996892625e0a6e13c868c988::beat {
    struct BEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAT>(arg0, 6, b"BEAT", b"eBeat AI", x"5265766f6c7574696f6e697a657320746865206d75736963206372656174696f6e2070726f6365737320627920636f6d62696e696e672074686520706f776572206f6620416c20616e6420426c6f636b636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738333184978.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

