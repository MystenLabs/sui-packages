module 0x4a84cee52be28b15ccaf679692aa8324dbc057e626843f18ea5533fa9efad9a6::yxz252426 {
    struct YXZ252426 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YXZ252426>, arg1: 0x2::coin::Coin<YXZ252426>) {
        0x2::coin::burn<YXZ252426>(arg0, arg1);
    }

    fun init(arg0: YXZ252426, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YXZ252426>(arg0, 9, b"YXZ", b"YXZ252426", b"YXZ Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/76983474")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YXZ252426>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YXZ252426>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YXZ252426>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YXZ252426>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

