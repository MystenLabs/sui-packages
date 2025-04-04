module 0x969c86d4497bcb7c71df104c551680a233db34199b1340cd428ff89f9ca39ec6::SAZU {
    struct SAZU has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAZU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAZU>>(0x2::coin::mint<SAZU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAZU>(arg0, 9, b"SAZU", b"Sazuest Coin", b"Description of the Sazuest Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/21pkMy4W/zzz.png"))), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAZU>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAZU>>(v2);
    }

    // decompiled from Move bytecode v6
}

