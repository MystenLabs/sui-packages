module 0x62004ba6c501ab3dec23d935528ad69c8f92c07781f9a2e01fc67a826a28c4d6::xxh {
    struct XXH has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXH>(arg0, 9, b"XXH", b"Xanthia", b"Walking on three legs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d441febc-7c8b-4e20-b43f-7258e7e1909e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XXH>>(v1);
    }

    // decompiled from Move bytecode v6
}

