module 0x3c4425a153c02f7eb16e852d9ec77c941a70f3744dc953ef32aab8c6a772eb9f::myra {
    struct MYRA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYRA>, arg1: 0x2::coin::Coin<MYRA>) {
        0x2::coin::burn<MYRA>(arg0, arg1);
    }

    fun init(arg0: MYRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYRA>(arg0, 6, b"MYRA", b"MYRAONSUI", b"The Woman Behind the Top Dog on Solana is ready to take her place as First Lady of Sol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GDqFKi5aQAINloV?format=png&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYRA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

