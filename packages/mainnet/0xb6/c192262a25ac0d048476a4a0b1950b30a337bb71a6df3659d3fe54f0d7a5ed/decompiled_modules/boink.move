module 0xb6c192262a25ac0d048476a4a0b1950b30a337bb71a6df3659d3fe54f0d7a5ed::boink {
    struct BOINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOINK>(arg0, 9, b"BOINK", b"BOINKER", b"Chase the stupid dream of getting to the moon by farming the ultimate game memecoin, $BOINK. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/370495fa-2b28-44ac-912f-3817ed88620a-IMG_9998.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

