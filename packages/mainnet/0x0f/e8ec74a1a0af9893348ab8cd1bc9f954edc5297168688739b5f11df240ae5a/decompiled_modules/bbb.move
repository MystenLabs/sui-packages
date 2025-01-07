module 0xfe8ec74a1a0af9893348ab8cd1bc9f954edc5297168688739b5f11df240ae5a::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 9, b"BBB", b"Blop", b"The next AAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/505c9f6d-eb9d-41f8-a6eb-e9a023fcfb0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

