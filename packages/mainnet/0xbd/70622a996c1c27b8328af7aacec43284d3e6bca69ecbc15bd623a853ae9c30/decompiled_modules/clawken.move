module 0xbd70622a996c1c27b8328af7aacec43284d3e6bca69ecbc15bd623a853ae9c30::clawken {
    struct CLAWKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAWKEN>, arg1: 0x2::coin::Coin<CLAWKEN>) {
        0x2::coin::burn<CLAWKEN>(arg0, arg1);
    }

    fun init(arg0: CLAWKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWKEN>(arg0, 6, b"CLAWKENBOT", b"Clawken", b"Launch your first agent token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fylkSja.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAWKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAWKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

