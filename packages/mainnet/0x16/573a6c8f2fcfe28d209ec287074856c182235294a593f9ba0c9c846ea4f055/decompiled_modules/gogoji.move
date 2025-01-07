module 0x16573a6c8f2fcfe28d209ec287074856c182235294a593f9ba0c9c846ea4f055::gogoji {
    struct GOGOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGOJI>(arg0, 9, b"GOGOJI", b"GOGO", b"Muje testnet mila", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9a5cd47-2be7-4563-b718-887ee1ab4415.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

