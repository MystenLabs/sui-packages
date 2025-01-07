module 0xd19d0b4ea8d5c05aad4995967965de139818559d64339c737ac9ec86f357514e::memek {
    struct MEMEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK>(arg0, 9, b"MEMEK", b"Airdrop", b"SPESIAL AIRDROP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e67d66b-96ae-4eee-b636-7bcbcad68328.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

