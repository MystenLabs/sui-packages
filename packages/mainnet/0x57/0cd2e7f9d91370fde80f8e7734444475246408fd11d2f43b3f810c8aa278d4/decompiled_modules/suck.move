module 0x570cd2e7f9d91370fde80f8e7734444475246408fd11d2f43b3f810c8aa278d4::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"SUCK", b"Suck Duck", x"48656c6c6f2c2049276d20245355434b0a546865207369636b6573742044636b206f6e20746865200a405375694e6574776f726b0a0a54656c656772616d202d2068747470733a2f2f742e6d652f5375636b5468654475636b58595a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suck_Duck_8bd9150693.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

