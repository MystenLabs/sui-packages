module 0xf9a81178003540111c2d8b5cba0a66539c96b35dcbc76d298c29bd9b9f036449::babywewe {
    struct BABYWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYWEWE>(arg0, 9, b"BABYWEWE", b"Baby-Wewe ", b"A Baby $Wewe on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/081e46df-a250-4c98-b3d0-75d036dd496f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

