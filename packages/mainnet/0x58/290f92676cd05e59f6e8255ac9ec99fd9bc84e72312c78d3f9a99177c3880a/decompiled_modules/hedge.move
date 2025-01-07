module 0x58290f92676cd05e59f6e8255ac9ec99fd9bc84e72312c78d3f9a99177c3880a::hedge {
    struct HEDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDGE>(arg0, 9, b"HEDGE", b"hedgehog", b"a cute hedgehog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e32ae1c1-5a93-4de9-878a-b11b4bd6781e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEDGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

