module 0x3ca7941575483fc0c0bba91bc552d71e701a12f7ce41f4d6a349d83092407dd4::by153 {
    struct BY153 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY153, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY153>(arg0, 9, b"BY153", b"AIY", b"artificial intelligence towards the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cb16400-8d35-47d5-be6a-6d986a045471.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY153>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY153>>(v1);
    }

    // decompiled from Move bytecode v6
}

