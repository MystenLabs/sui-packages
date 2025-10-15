module 0xbe68b1545a2dc199bdf84da8725a1f31a7b0c1d0622670b0cccacfb42e3faff0::hmpt {
    struct HMPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMPT>(arg0, 6, b"HMPT", b"Humpty Dumpty", b"Do the Humpty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760556040954.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

