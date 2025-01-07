module 0xbcabac6429f9664dfb7d5d66e65352a2a68b7b7803e4d8f09a15e13f4729a940::jigg_z {
    struct JIGG_Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGG_Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGG_Z>(arg0, 9, b"JIGG_Z", b"Jiggy ", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7080734d-bc85-4923-8b71-97d79effdb46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGG_Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIGG_Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

