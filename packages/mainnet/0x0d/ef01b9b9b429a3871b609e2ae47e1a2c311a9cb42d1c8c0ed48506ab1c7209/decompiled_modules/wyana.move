module 0xdef01b9b9b429a3871b609e2ae47e1a2c311a9cb42d1c8c0ed48506ab1c7209::wyana {
    struct WYANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYANA>(arg0, 9, b"WYANA", b"WaveYana S", x"576176652079616e61206973206120444558205377617020466f7220535549202b204d6f726520616e64206d6f726520746f20626520616e6e6f756e63656420736f6f6e20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80c10b0a-7c72-48c4-b293-55513d28cd9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

