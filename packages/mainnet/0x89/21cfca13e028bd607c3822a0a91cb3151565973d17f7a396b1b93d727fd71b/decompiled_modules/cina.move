module 0x8921cfca13e028bd607c3822a0a91cb3151565973d17f7a396b1b93d727fd71b::cina {
    struct CINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CINA>(arg0, 9, b"CINA", b"Cinamoroll", b"J4fun <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a45759e-b6db-4b5f-9ae7-b5987bacb457.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

