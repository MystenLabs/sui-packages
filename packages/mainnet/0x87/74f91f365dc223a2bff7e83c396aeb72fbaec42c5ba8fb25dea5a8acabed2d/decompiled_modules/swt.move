module 0x8774f91f365dc223a2bff7e83c396aeb72fbaec42c5ba8fb25dea5a8acabed2d::swt {
    struct SWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWT>(arg0, 6, b"SWT", b"SALTWATER TAFFY", b"The Sweetest Token on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sweet_5f7b18e6a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

