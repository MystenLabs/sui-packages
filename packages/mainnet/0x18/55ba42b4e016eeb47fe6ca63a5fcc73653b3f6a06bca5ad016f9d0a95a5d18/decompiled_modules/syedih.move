module 0x1855ba42b4e016eeb47fe6ca63a5fcc73653b3f6a06bca5ad016f9d0a95a5d18::syedih {
    struct SYEDIH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYEDIH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYEDIH>(arg0, 6, b"Syedih", b"Agus On Sui", b"Aguus Syediiih", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987134394.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYEDIH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYEDIH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

