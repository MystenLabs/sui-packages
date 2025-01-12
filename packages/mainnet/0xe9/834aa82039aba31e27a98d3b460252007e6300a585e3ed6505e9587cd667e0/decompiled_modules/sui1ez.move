module 0xe9834aa82039aba31e27a98d3b460252007e6300a585e3ed6505e9587cd667e0::sui1ez {
    struct SUI1EZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI1EZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI1EZ>(arg0, 6, b"Sui1ez", b"Sui1ezAI", x"535549206e6574776f726b277320666972737420616e696d652d62617365642041492070726f6a6563742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736708365803.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI1EZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI1EZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

