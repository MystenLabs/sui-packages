module 0xae22cc59230dc9d7abe04cf33372df15330d7b0e0980c7612b55a085ce7bc651::htruck {
    struct HTRUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTRUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTRUCK>(arg0, 9, b"HTRUCK", b"Honk Truck", b"Honk honk honk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85d6182c-9f55-4e58-bafd-a2f58c20cf56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTRUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTRUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

