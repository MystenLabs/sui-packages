module 0x57f95ec036346088bf8521406a885d6cd6b202cf3a7f6e4939c33b00a75a79fe::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XRP>(arg0, 6, b"XRP", b"XRP By SuiAI by SuiAI", b"Everyone on TikTok is hyped about XRP, but no one knows what it actually is. Time for the real $XRP on SUI by SuiAI to take over.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/33_4aabe6473b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XRP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

