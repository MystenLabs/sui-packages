module 0xb243adcf81318f3a3babb34e03285496cd2bf7ef5d7b6eff83fe95bc8653e620::kpr {
    struct KPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KPR>(arg0, 9, b"KPR", b"keeper", b"Meme token like my dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ca0b66a-d630-4aff-85f3-bfbd28ae9354.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

