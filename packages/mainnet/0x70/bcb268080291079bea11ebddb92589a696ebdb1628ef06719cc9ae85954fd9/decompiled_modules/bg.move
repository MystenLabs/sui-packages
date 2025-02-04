module 0x70bcb268080291079bea11ebddb92589a696ebdb1628ef06719cc9ae85954fd9::bg {
    struct BG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BG>(arg0, 6, b"BG", b"BabyGoat", x"f09f9090", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738711713549.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

