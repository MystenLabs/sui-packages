module 0xb7326f2ed5aaa5e31c4002a408701353de0367d29eacab6648eb1f838392e051::him {
    struct HIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIM>(arg0, 9, b"HIM", b"CATHIM", b"This is my cat and I want to launch it into space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17af0e08-6f11-453b-bfcb-1985c47a71e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

