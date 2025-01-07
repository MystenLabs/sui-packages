module 0x22835d6ed96f9b1a5be5eabafc7d799a048937e45ab3761ddad27f97de6edd65::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 9, b"FAUCET", b"Sui faucet", b"A place to move your Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56c6d5fb-6351-4104-87a0-035314fad71e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
    }

    // decompiled from Move bytecode v6
}

