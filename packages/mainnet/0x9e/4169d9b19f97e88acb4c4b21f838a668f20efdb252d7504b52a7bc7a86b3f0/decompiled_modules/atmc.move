module 0x9e4169d9b19f97e88acb4c4b21f838a668f20efdb252d7504b52a7bc7a86b3f0::atmc {
    struct ATMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATMC>(arg0, 9, b"ATMC", b"ATOMIC", b"ATOMIC MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0eb4b51c-9321-474c-b2ed-bb4f261228d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

