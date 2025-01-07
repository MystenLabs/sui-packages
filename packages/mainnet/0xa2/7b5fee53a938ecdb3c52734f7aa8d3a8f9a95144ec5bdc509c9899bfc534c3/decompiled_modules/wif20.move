module 0xa27b5fee53a938ecdb3c52734f7aa8d3a8f9a95144ec5bdc509c9899bfc534c3::wif20 {
    struct WIF20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIF20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF20>(arg0, 9, b"WIF20", b"Wawewifhat", b"Enjoy the fun of the sui Tsunami festival", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a757fae4-3d35-4486-bd2a-22e8505fe036.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIF20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIF20>>(v1);
    }

    // decompiled from Move bytecode v6
}

