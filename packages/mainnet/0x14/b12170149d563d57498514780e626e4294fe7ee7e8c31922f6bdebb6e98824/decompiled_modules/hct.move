module 0x14b12170149d563d57498514780e626e4294fe7ee7e8c31922f6bdebb6e98824::hct {
    struct HCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCT>(arg0, 6, b"HCT", b"HOPcat", b"First cat on Hop Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CAT_f78fc07120.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

