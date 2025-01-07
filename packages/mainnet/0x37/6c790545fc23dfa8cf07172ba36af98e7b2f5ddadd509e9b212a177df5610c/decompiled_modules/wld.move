module 0x376c790545fc23dfa8cf07172ba36af98e7b2f5ddadd509e9b212a177df5610c::wld {
    struct WLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLD>(arg0, 9, b"WLD", b"WILDLIFE ", b"WILDLIFE is a community-driven meme coin that celebrates the excitement and energy of the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b90ec381-0566-40ad-b24e-b7e38c584baa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

