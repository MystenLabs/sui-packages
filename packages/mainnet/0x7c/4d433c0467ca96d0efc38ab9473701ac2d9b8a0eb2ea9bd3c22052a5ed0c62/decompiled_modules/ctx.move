module 0x7c4d433c0467ca96d0efc38ab9473701ac2d9b8a0eb2ea9bd3c22052a5ed0c62::ctx {
    struct CTX has drop {
        dummy_field: bool,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CTX>, arg1: 0x2::coin::Coin<CTX>) {
        0x2::coin::burn<CTX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CTX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CTX>>(0x2::coin::mint<CTX>(arg0, arg1, arg3), arg2);
    }

    public fun balance(arg0: &0x2::coin::Coin<CTX>) : u64 {
        0x2::coin::value<CTX>(arg0)
    }

    fun init(arg0: CTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTX>(arg0, 9, b"NS", b"SuiNS Token", b"The native token for the SuiNS Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://token-image.suins.io/icon.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTX>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CTX>>(v0);
    }

    // decompiled from Move bytecode v6
}

