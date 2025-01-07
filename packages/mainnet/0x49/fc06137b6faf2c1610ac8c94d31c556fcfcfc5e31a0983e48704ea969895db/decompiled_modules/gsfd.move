module 0x49fc06137b6faf2c1610ac8c94d31c556fcfcfc5e31a0983e48704ea969895db::gsfd {
    struct GSFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSFD>(arg0, 9, b"GSFD", b"FDHD", b"SCG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38325535-fcaa-4210-891f-e2b5f9168283.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

