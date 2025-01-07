module 0xf3af6d20338556cc58fbf7fb42608a764e5366d058f0791b5d736d1c09d49137::big12shark {
    struct BIG12SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG12SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG12SHARK>(arg0, 9, b"BIG12SHARK", b"Aaanew", b"Nicely to start, LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/862e9df2-a466-4d68-95e7-1764bfe35b68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG12SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG12SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

