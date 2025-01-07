module 0x54ec92aa668d62a88a3e495e2aca41e3156601ff9b1d3812486d77199bc63026::swt {
    struct SWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWT>(arg0, 6, b"SWT", b"SALTWATER TAFFY", b"The Sweetest Token on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sweet_c2e26dadef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

