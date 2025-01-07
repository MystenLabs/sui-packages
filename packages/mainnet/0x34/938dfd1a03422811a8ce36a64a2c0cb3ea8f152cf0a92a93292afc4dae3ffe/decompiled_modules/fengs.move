module 0x34938dfd1a03422811a8ce36a64a2c0cb3ea8f152cf0a92a93292afc4dae3ffe::fengs {
    struct FENGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGS>(arg0, 6, b"FENGS", b"FengSui", b"Means Water-Wind. Water flows with harmony, Wind helps the flow and provides a cool breath of fresh air. Degens have been exposed to the chaos of the battle beteen jeeting and non-jeeting to the point that they have forgotten about inner peace. $FENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012637649.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FENGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

