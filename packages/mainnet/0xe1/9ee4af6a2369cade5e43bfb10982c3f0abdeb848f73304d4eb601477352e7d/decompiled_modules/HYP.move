module 0xe19ee4af6a2369cade5e43bfb10982c3f0abdeb848f73304d4eb601477352e7d::HYP {
    struct HYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYP>(arg0, 6, b"HYP", b"hyperpigmentation", b"anybody can be an artist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmebNaUHWtkxD1hNW21Wd9NGFS1qkHpoAN8BBhBfeDWTKo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

