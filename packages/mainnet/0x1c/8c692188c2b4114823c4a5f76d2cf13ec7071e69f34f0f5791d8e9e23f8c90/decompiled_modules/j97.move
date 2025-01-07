module 0x1c8c692188c2b4114823c4a5f76d2cf13ec7071e69f34f0f5791d8e9e23f8c90::j97 {
    struct J97 has drop {
        dummy_field: bool,
    }

    fun init(arg0: J97, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J97>(arg0, 9, b"J97", b"Jack 97", b"Jack is a cheapskate, abandons his children, lives with his dog and plagiarizes The Weeknd's music.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ef89081-05a4-45d3-9b88-deaca9a65d57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J97>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J97>>(v1);
    }

    // decompiled from Move bytecode v6
}

