module 0x3019d4579978963af8b9850dade859e7ec3203c96c83789976408de7d95199e1::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 9, b"PAT", b"Patvana", b"Just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfe118ad-0aa9-4d71-aee8-ecc09c31b517.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

