module 0x50e785ea22f318eaaa8424599838ddc2316d012f5d47d7cd9bbec8b7ce475045::snd {
    struct SND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SND>(arg0, 9, b"SND", b"SNOPPDY", b"Token meme for community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c107b9b8-6c85-477c-ba0c-382ee907f4a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SND>>(v1);
    }

    // decompiled from Move bytecode v6
}

