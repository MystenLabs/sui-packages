module 0x4466a5cd8947dfceb90a23bbd06a99746afffba0019b63b6024b386baae0226e::moby {
    struct MOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 6, b"MOBY", b"MOBY on SUI", x"546865206669727374206c61756e6368206f6e20547572626f730a244d4f4259202d207468652067696761207768616c65206f6e20405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960931959.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

