module 0x1d322d41f5f6072f2da1ab615963ff1029e773f84071541d6e1de25a14b0813::nice {
    struct NICE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NICE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NICE>>(0x2::coin::mint<NICE>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: NICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICE>(arg0, 9, b"NICE", b"Wow Nice Token", b"this is where a description would go if this was a public drop.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plz.money/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NICE>>(0x2::coin::mint<NICE>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NICE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

