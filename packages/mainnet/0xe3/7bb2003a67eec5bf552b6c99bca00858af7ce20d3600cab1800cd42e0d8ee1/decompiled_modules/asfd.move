module 0xe37bb2003a67eec5bf552b6c99bca00858af7ce20d3600cab1800cd42e0d8ee1::asfd {
    struct ASFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASFD>(arg0, 9, b"ASFD", b"af", b"FASF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/796984c8-b034-4993-88a8-d760141494b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

