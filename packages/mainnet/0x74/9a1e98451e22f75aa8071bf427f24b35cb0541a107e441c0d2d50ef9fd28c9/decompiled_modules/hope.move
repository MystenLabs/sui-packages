module 0x749a1e98451e22f75aa8071bf427f24b35cb0541a107e441c0d2d50ef9fd28c9::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 6, b"HOPE", b"Hope Sui", b"Hope is a symbolic representation within the pepe meme culture, intended to evoke the same sense of joy and camaraderie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731594883338.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

