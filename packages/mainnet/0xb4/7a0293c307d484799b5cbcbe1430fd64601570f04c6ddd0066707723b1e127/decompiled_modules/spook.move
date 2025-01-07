module 0xb47a0293c307d484799b5cbcbe1430fd64601570f04c6ddd0066707723b1e127::spook {
    struct SPOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOK>(arg0, 6, b"SPOOK", b"SpookiSui", x"54686520467269656e646c696573742047686f7374204f6e20537569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958225283.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

