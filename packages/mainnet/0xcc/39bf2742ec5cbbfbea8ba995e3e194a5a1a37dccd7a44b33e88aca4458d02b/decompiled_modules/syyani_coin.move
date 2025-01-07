module 0xcc39bf2742ec5cbbfbea8ba995e3e194a5a1a37dccd7a44b33e88aca4458d02b::syyani_coin {
    struct SYYANI_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SYYANI_COIN>, arg1: 0x2::coin::Coin<SYYANI_COIN>) {
        0x2::coin::burn<SYYANI_COIN>(arg0, arg1);
    }

    fun init(arg0: SYYANI_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYYANI_COIN>(arg0, 9, b"SYYANI_COIN", b"SYYANI", b"syyani coin, my first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/40732861")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYYANI_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYYANI_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SYYANI_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SYYANI_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

