module 0xdde1dcbf17113151c83108ad2782b8051c2a9bd4d3db864f322df52228dc794d::kama {
    struct KAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMA>(arg0, 9, b"KAMA", b"Kamala", b"Kamala harris meme is so to the moon in the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4c183d9-3e1c-4797-be40-408f5920630d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

