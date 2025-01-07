module 0xf4de2776c393e8ce47d6dfe77eaa82ed7d558875e67f16f8bc9bd5c45176f12f::sha {
    struct SHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHA>(arg0, 9, b"SHA", b"Shaly ", b"Shaly on$SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc116f6b-98ca-4492-8258-73cb92f6fdef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

