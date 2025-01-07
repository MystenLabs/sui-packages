module 0x5901ae10155634ea9ca7042953bbc3008666b8580e590494e256b7ebc345b1a4::mmm {
    struct MMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMM>(arg0, 9, b"MMM", b"Mememy", b"Is a token for degen lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01ef2bd3-7101-4410-a384-3b75db0ccd89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

