module 0x23b4b935aa51e1e90421e742094402491e5aae8c44967ed1d32944cde8dc4fe0::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW>(arg0, 9, b"WW", b"WeiWei", b"WeiWei is a utility token designed for seamless, high-speed transactions within decentralized platforms. With a focus on reducing fees and enhancing user experience, EtherWave is the future of payment solutions in the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c295318-dae0-4dc8-b67b-49d0b8915353.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WW>>(v1);
    }

    // decompiled from Move bytecode v6
}

