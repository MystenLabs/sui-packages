module 0xc6d1cb347faf61fb743d09cf91be7280960052374a3e894342ce947b2de3e56f::wlbtc {
    struct WLBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLBTC>(arg0, 8, b"WLBTC", b"wLBTC", b"Bridge wrapped LBTC token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/LBTC.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

