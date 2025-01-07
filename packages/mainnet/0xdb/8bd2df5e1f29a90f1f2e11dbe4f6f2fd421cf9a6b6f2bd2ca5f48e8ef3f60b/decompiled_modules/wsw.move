module 0xdb8bd2df5e1f29a90f1f2e11dbe4f6f2fd421cf9a6b6f2bd2ca5f48e8ef3f60b::wsw {
    struct WSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSW>(arg0, 9, b"WSW", b"WISDOM WIS", b"Future great project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c158420f-c86b-4e65-a9c7-f5929a59bf79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSW>>(v1);
    }

    // decompiled from Move bytecode v6
}

