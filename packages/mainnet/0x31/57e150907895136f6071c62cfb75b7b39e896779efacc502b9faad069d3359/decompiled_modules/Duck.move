module 0x3157e150907895136f6071c62cfb75b7b39e896779efacc502b9faad069d3359::Duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUCK>, arg1: 0x2::coin::Coin<DUCK>) {
        0x2::coin::burn<DUCK>(arg0, arg1);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<DUCK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUCK>>(0x2::coin::split<DUCK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 9, b"DUCK", b"Sick my duck", b"Please sick my duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/fTjS8ZB3/duck.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DUCK>>(0x2::coin::mint<DUCK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

