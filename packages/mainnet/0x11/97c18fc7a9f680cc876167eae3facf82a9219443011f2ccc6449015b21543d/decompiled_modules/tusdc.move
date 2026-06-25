module 0x1197c18fc7a9f680cc876167eae3facf82a9219443011f2ccc6449015b21543d::tusdc {
    struct TUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSDC>(arg0, 6, b"tUSDC", b"Alakazam Test USD", b"Staging test USD coin for Alakazam staging-on-mainnet ceremony", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

