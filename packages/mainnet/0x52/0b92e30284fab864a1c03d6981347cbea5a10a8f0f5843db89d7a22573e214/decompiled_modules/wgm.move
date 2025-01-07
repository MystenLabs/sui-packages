module 0x520b92e30284fab864a1c03d6981347cbea5a10a8f0f5843db89d7a22573e214::wgm {
    struct WGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGM>(arg0, 9, b"WGM", b"WingDom", b"Meme Coin For Trading of Gamers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1751e0c-7e95-492b-8aad-7c961d7c23f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

