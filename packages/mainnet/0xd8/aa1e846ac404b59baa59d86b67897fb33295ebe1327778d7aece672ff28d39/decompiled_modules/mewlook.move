module 0xd8aa1e846ac404b59baa59d86b67897fb33295ebe1327778d7aece672ff28d39::mewlook {
    struct MEWLOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWLOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWLOOK>(arg0, 9, b"MEWLOOK", b"MEOLOOK", b"cat looking hooman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89ed349a-3210-479c-9024-718c4f39c5d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWLOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWLOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

