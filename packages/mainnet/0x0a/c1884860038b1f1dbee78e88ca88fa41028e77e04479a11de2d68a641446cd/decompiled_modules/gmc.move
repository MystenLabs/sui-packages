module 0xac1884860038b1f1dbee78e88ca88fa41028e77e04479a11de2d68a641446cd::gmc {
    struct GMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMC>(arg0, 9, b"GMC", b"Grumpy Cat", b"A famous meme cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14675eba-5ee7-4657-b783-739dbb05a27a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

