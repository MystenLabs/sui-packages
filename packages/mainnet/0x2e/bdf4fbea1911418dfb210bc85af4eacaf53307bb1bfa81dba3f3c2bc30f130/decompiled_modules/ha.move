module 0x2ebdf4fbea1911418dfb210bc85af4eacaf53307bb1bfa81dba3f3c2bc30f130::ha {
    struct HA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HA>, arg1: 0x2::coin::Coin<HA>) {
        0x2::coin::burn<HA>(arg0, arg1);
    }

    fun init(arg0: HA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HA>(arg0, 6, b"HA", b"ha", b"hahaha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

