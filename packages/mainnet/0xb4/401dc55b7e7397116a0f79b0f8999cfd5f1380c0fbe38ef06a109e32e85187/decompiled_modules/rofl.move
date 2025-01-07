module 0xb4401dc55b7e7397116a0f79b0f8999cfd5f1380c0fbe38ef06a109e32e85187::rofl {
    struct ROFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROFL>(arg0, 9, b"ROFL", b"ROFL COIN", b"Unleashing the Memecoin Revolution Rolling on floor laughing meme ($ROFL) was created to make scam. I lost $ 192 to acquire it, the early project was before meme coin era was just started.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cd02dde-bd44-4016-9f21-9f568927d88b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

