module 0x4d825e605480be9a02c3309c86c23c003316f08a23cafde5745b34b24b582468::trp {
    struct TRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRP>(arg0, 9, b"TRP", b"TrumpPutin", b"Meme president US and Russian", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2069d93a-17d9-4239-a251-4d6c9bd4a37c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

