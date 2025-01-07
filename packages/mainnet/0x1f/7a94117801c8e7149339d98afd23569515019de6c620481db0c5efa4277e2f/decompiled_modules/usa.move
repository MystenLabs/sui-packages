module 0x1f7a94117801c8e7149339d98afd23569515019de6c620481db0c5efa4277e2f::usa {
    struct USA has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USA>(arg0, 6, b"USA", b"American Coin", b"USA elections 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730596207977.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

