module 0x233eb29e92d9fef74a19a7cfcda25c8554615d7e353f8807ae34ee8900aa5e8a::ssl {
    struct SSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSL>(arg0, 6, b"SSL", b"Simple Sui Long", b"Represents a share of this vaults liquidity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

