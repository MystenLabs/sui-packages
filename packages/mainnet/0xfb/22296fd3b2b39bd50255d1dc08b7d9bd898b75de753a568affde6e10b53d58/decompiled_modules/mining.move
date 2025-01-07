module 0xfb22296fd3b2b39bd50255d1dc08b7d9bd898b75de753a568affde6e10b53d58::mining {
    struct MINING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINING>(arg0, 9, b"MINING", b"Blum", b"Telegram mining project blum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e50a1e4a-3140-4d81-b7f5-ccdcb38d10cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINING>>(v1);
    }

    // decompiled from Move bytecode v6
}

