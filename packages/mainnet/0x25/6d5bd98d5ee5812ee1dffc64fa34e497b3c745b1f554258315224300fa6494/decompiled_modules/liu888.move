module 0x256d5bd98d5ee5812ee1dffc64fa34e497b3c745b1f554258315224300fa6494::liu888 {
    struct LIU888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIU888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIU888>(arg0, 9, b"LIU888", b"XXX", b"rsghfbfbbfbfb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0642a5f8-a7f1-488e-b4bb-460a2aa9c02a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIU888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIU888>>(v1);
    }

    // decompiled from Move bytecode v6
}

