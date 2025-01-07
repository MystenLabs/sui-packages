module 0x1f3654e695b6d1e97b2b301a671b71a0e91d656c4e460d275202222a24f8dff9::df {
    struct DF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DF>(arg0, 9, b"DF", b"KJH", b"BBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00b33d88-ac54-414b-88a1-fab128da9301.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DF>>(v1);
    }

    // decompiled from Move bytecode v6
}

