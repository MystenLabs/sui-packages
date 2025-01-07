module 0x2a6004eff903f270d0ff7ebc6108152a4b8072f89c9624362f42bbf018f58d9d::btrf {
    struct BTRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTRF>(arg0, 9, b"BTRF", b"butterfly", x"57696e67656420656d6f74696f6e73f09fa68bf09fa68bf09fa68bf09fa68bf09fa68bf09fa68b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95542c30-4f44-4238-bed2-e64e30b4d7bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

