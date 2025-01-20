module 0x19ce44d7cfbcdd020a7301be558db961d3c3f0c7f98926e21a6f5f68d54b8aff::gst {
    struct GST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GST>(arg0, 6, b"Gst", b"Growing India ", b"Budget is low can't launch on Solana so launching on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737394141334.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

