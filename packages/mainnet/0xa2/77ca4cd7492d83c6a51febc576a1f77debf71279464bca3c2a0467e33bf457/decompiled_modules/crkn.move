module 0xa277ca4cd7492d83c6a51febc576a1f77debf71279464bca3c2a0467e33bf457::crkn {
    struct CRKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRKN>(arg0, 9, b"CRKN", b"Cracken", b"Ocean giant octopas new era of ocean king meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba1f8946-9633-44f3-9d7f-0bf71bae1db0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

