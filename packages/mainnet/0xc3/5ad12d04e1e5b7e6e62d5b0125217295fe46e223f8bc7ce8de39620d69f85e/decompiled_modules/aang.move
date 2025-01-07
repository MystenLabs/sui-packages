module 0xc35ad12d04e1e5b7e6e62d5b0125217295fe46e223f8bc7ce8de39620d69f85e::aang {
    struct AANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AANG>(arg0, 9, b"AANG", b"Aang", b"Last airbender", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bc7d40c-fa23-448f-b406-c0bafabfc00a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

