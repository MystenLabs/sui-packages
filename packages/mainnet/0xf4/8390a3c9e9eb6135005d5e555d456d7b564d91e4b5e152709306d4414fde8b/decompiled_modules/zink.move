module 0xf48390a3c9e9eb6135005d5e555d456d7b564d91e4b5e152709306d4414fde8b::zink {
    struct ZINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZINK>(arg0, 9, b"ZINK", b"jienx", b" X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0645b345-a043-47ce-ab28-09cafc82a5ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

