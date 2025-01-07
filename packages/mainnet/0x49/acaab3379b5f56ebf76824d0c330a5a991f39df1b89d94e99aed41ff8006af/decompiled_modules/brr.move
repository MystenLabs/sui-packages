module 0x49acaab3379b5f56ebf76824d0c330a5a991f39df1b89d94e99aed41ff8006af::brr {
    struct BRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRR>(arg0, 6, b"BRR", b"BRR SUI", x"576861742069732068617070656e696e67206f6e2045617274683f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731435167056.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

