module 0x3f73d4d4fb4a97981a04f427ef7f4d470b3288ee0fbd0df3ad09b9e578aecc6a::ggon {
    struct GGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGON>(arg0, 9, b"GGON", b"Gaga on", b"Meme for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be10516c-519a-469b-a974-ec0bc050f19b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

