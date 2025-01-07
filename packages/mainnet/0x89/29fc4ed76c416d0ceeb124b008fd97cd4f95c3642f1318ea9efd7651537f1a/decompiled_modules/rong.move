module 0x8929fc4ed76c416d0ceeb124b008fd97cd4f95c3642f1318ea9efd7651537f1a::rong {
    struct RONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONG>(arg0, 9, b"RONG", b"Dragon on ", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/549627c0-d5f4-4635-beea-14a4beec613c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

