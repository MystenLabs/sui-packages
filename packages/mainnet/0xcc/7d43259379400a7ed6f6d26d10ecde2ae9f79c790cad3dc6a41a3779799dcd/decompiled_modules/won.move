module 0xcc7d43259379400a7ed6f6d26d10ecde2ae9f79c790cad3dc6a41a3779799dcd::won {
    struct WON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WON>, arg1: 0x2::coin::Coin<WON>) {
        0x2::coin::burn<WON>(arg0, arg1);
    }

    fun init(arg0: WON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WON>(arg0, 9, b"!111 111 1111 111! 22222 222 2222 222 22: 333.333-3333333.333", b"won", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Bhcub7a.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WON>>(v1);
        0x2::coin::mint_and_transfer<WON>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WON>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

