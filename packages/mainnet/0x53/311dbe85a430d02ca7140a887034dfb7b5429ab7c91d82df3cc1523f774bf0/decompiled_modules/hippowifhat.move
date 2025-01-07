module 0x53311dbe85a430d02ca7140a887034dfb7b5429ab7c91d82df3cc1523f774bf0::hippowifhat {
    struct HIPPOWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOWIFHAT>(arg0, 6, b"HIPPOWIFHAT", b"Hippo Wif Hat", b"A hippo... wearing a hat. Enough said. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hippo_Wif_Hat_1_48c642208f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

