module 0xe834619103df64d3193e1e379b26e6bf8b7b3f1024956977f5a91c6efb03e6fd::hjyhadiza {
    struct HJYHADIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJYHADIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJYHADIZA>(arg0, 9, b"HJYHADIZA", b"Had", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b497650-589f-4a6d-abf9-cd235a848b2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJYHADIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJYHADIZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

