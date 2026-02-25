module 0x75319d9a56299e8e2c2e4e28924b7e9f3e0f2bd050ec1ca87d51850ef805492c::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"PAT", b"Pure Alpha Trading Vault", b"Alpha for all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Rozzy122/PATV-Logo/main/Pure%20Alpha%20Trading%20Vault.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

