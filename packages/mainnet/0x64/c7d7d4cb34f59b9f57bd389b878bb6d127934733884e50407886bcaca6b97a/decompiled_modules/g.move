module 0x64c7d7d4cb34f59b9f57bd389b878bb6d127934733884e50407886bcaca6b97a::g {
    struct G has drop {
        dummy_field: bool,
    }

    fun init(arg0: G, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<G>(arg0, 6, b"G", b"Good", b"@suilaunchcoin $G + Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/g-d4bv82.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<G>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

