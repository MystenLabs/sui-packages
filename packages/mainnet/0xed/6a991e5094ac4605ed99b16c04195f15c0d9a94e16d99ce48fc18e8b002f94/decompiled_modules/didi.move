module 0xed6a991e5094ac4605ed99b16c04195f15c0d9a94e16d99ce48fc18e8b002f94::didi {
    struct DIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDI>(arg0, 9, b"DIDI", b"WEWE", b"DIDI to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1757f67a-30a8-4747-ae5a-6f3f2129fe2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

