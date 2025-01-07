module 0x9255515cc08520f7a5232ccd6ecc1c95798b8d85804a624752ddbab64e2abc4a::meta {
    struct META has drop {
        dummy_field: bool,
    }

    fun init(arg0: META, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<META>(arg0, 8, b"META", b"Wrapped token for META PLATFORMS INC", b"Sudo Virtual Coin for META PLATFORMS INC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<META>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<META>>(v0);
    }

    // decompiled from Move bytecode v6
}

