module 0x5a475448bb873fd3b21c263c88871c866669decb7cdf7d79d19e0b5903fb249f::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BOS", b"Build On Sui", b"This is BOS - Sui mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731802894650.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

