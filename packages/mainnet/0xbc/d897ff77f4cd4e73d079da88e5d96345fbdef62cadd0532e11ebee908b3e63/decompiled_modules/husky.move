module 0xbcd897ff77f4cd4e73d079da88e5d96345fbdef62cadd0532e11ebee908b3e63::husky {
    struct HUSKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HUSKY>, arg1: 0x2::coin::Coin<HUSKY>) {
        0x2::coin::burn<HUSKY>(arg0, arg1);
    }

    fun init(arg0: HUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSKY>(arg0, 6, b"HUSKY", b"HUSKY", b"let $husky meme token fill out your bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/MhQvmYk/husky.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HUSKY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HUSKY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

