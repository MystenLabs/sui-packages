module 0xa83217e8792598fad99579385f3463e926a5b2ea59e07c13789cdb6dd4517a30::hfdh {
    struct HFDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFDH>(arg0, 9, b"HFDH", b"HSFH", b"SG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d084eb45-a837-4db3-afb9-5f10c60e04ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

