module 0x1afa12e7f743901bff46ef12ccafe05a407b38a063bbf2329c42f2c69a768b8f::mn {
    struct MN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MN>(arg0, 9, b"MN", b"$MANN", x"46756e20546f6b656e2c2066726f6d20636f6d6d756e697479206f6620746865206368616e6e656c20e2809c447265616d20576f726b20696e2043727970746fe2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/878200db-046c-47b0-86b7-3ec9b403ac8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MN>>(v1);
    }

    // decompiled from Move bytecode v6
}

