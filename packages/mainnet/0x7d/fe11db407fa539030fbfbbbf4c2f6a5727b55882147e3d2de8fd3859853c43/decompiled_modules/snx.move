module 0x7dfe11db407fa539030fbfbbbf4c2f6a5727b55882147e3d2de8fd3859853c43::snx {
    struct SNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNX>(arg0, 9, b"SNX", b"Sunusu", b"Snxtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6cf8645-e89b-4a59-9913-901038cf7d35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

