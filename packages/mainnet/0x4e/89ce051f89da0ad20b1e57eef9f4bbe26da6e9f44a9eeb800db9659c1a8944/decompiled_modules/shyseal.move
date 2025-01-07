module 0x4e89ce051f89da0ad20b1e57eef9f4bbe26da6e9f44a9eeb800db9659c1a8944::shyseal {
    struct SHYSEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHYSEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHYSEAL>(arg0, 9, b"SHYSEAL", b"Shy Seal", b"A famous meme on reddit. The Shy Seal meme features a harbor seal with a wide-eyed expression that can easily be interpreted as awkward or innocent. It originated from a specific photo of a seal at the Cornish Seal Sanctuary in the UK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/105858b3-a8ad-4146-bb35-c077b0830059.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHYSEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHYSEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

