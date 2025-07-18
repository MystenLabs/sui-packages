module 0x9b9d417e01ea15708cd28d929747c2e74555ae6f355469888c3153aae77cac8e::poops {
    struct POOPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPS>(arg0, 6, b"Poops", b"POOP Sui", b"Poop coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigrwi2gsh72lai2kjv5c2644yffokougbljo3cb5gflpnga7h237q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POOPS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

