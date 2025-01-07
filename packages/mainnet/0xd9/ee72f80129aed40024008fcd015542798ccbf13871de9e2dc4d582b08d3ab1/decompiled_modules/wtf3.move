module 0xd9ee72f80129aed40024008fcd015542798ccbf13871de9e2dc4d582b08d3ab1::wtf3 {
    struct WTF3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF3>(arg0, 9, b"WTF3", b"WTTTTF", b"WTF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/693e41a6-7b56-4b1e-8405-2e9b4b952949.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTF3>>(v1);
    }

    // decompiled from Move bytecode v6
}

