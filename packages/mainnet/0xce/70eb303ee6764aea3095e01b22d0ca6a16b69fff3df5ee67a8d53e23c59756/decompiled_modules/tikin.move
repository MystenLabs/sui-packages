module 0xce70eb303ee6764aea3095e01b22d0ca6a16b69fff3df5ee67a8d53e23c59756::tikin {
    struct TIKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKIN>(arg0, 9, b"TIKIN", b"Count", b"Let's get there fast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/119cb4c5-6673-433e-a1d0-651c6eb66604.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

