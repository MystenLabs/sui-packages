module 0xb289842a203f633d443716d95b16802a6ca9017827a04b489b2a76c250810b37::memecats99 {
    struct MEMECATS99 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECATS99, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECATS99>(arg0, 9, b"MEMECATS99", b"MEMECATS", b"MEME CAT IS A MEME CURRENCY CREATED BY ME. I hope you will join in enthusiastically. THANK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/797b6253-9679-4da7-800d-76f55079a54b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECATS99>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECATS99>>(v1);
    }

    // decompiled from Move bytecode v6
}

