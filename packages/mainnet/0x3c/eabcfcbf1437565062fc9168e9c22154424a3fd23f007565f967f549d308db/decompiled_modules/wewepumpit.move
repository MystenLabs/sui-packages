module 0x3ceabcfcbf1437565062fc9168e9c22154424a3fd23f007565f967f549d308db::wewepumpit {
    struct WEWEPUMPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEPUMPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEPUMPIT>(arg0, 9, b"WEWEPUMPIT", b"WEWEcat ", b"Let's go pump it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6346d31d-3844-41be-aafc-139920976288.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEPUMPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEPUMPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

