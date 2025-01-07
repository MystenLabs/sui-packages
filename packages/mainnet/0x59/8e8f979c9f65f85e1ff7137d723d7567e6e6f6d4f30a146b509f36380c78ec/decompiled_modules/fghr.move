module 0x598e8f979c9f65f85e1ff7137d723d7567e6e6f6d4f30a146b509f36380c78ec::fghr {
    struct FGHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGHR>(arg0, 9, b"FGHR", b"thefighter", b"Unleash your inner warrior in the crypto ring.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dd4f868-54e2-448c-a554-c1482c942306.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

