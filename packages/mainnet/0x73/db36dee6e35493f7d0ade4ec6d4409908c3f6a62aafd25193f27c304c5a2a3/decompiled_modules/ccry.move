module 0x73db36dee6e35493f7d0ade4ec6d4409908c3f6a62aafd25193f27c304c5a2a3::ccry {
    struct CCRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCRY>(arg0, 9, b"CCRY", b"CATCRY", b"Why airdrop ban me :< ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7412f0a3-e38b-4e94-9e89-cf293f14bfc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

