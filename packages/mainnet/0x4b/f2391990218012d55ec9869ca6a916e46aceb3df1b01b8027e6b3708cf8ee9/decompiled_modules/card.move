module 0x4bf2391990218012d55ec9869ca6a916e46aceb3df1b01b8027e6b3708cf8ee9::card {
    struct CARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARD>(arg0, 9, b"CARD", b"RED CAR", x"497420656d626f646965732073706565642c20696e6e6f766174696f6e20616e64207374796c650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52d7be0d-dad6-4f56-b604-a5fa4f0d4455.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

