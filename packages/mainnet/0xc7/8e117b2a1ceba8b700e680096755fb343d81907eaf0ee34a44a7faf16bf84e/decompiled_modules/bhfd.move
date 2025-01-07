module 0xc78e117b2a1ceba8b700e680096755fb343d81907eaf0ee34a44a7faf16bf84e::bhfd {
    struct BHFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHFD>(arg0, 9, b"BHFD", b"DSAF", b"EWT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59cba6f9-8d0e-4a99-a62c-033736dd9e2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

