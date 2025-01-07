module 0x71b6940901ae77280b36392b5afe6d1dd71a06ccdaea762e5299c34c8232a487::dis {
    struct DIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIS>(arg0, 6, b"DIS", b"Diddy on the SUI", x"4865726520697320746865205061727479206f662044696464792c2077656c636f6d652067757973207e7e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732312335835.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

