module 0x565297a543cd1d3cd4f7f331c7819e95f4faf3e2031b15c47aae3b6d59fa1480::dvr {
    struct DVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DVR>(arg0, 9, b"DVR", b"Derouv", b"Derouv Coin is a hypothetical digital currency designed for secure, fast and transparent transactions.The Derouv Coin embodies innovation, reliability and global connectivity, fostering trust among users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a53c87c-324e-4f5f-a034-73c281b7c330.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

