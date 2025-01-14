module 0xb68f02e36178b3f8ad9677e3e9831e45f47a01900c308e15cbc447547f5be2ad::sheesh {
    struct SHEESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEESH>(arg0, 6, b"SHEESH", b"Sheesh", b"Sheesh! Chill out bro. Yea, you've found a gem. Yea, you'll have enough money for that lambo you always dreamt of. Yes, yes, you can feed your village. Sheesh. Just join us already...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736879954803.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEESH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEESH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

