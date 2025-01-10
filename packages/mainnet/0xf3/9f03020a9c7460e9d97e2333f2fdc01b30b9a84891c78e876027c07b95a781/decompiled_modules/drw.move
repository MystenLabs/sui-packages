module 0xf39f03020a9c7460e9d97e2333f2fdc01b30b9a84891c78e876027c07b95a781::drw {
    struct DRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DRW>(arg0, 6, b"DRW", x"447265616d20776f726c6420f09f8c8e206279205375694149", b"Simulated reality when AI surpasses human intelligence . We'll be living in a world indistinguishable from reality.And AI will be the ones designing and controlling it. Dream world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20250111_WA_0000_4906f0d0ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

