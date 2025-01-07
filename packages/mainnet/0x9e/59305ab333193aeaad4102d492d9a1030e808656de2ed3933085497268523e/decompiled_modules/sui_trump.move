module 0x9e59305ab333193aeaad4102d492d9a1030e808656de2ed3933085497268523e::sui_trump {
    struct SUI_TRUMP has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 8, b"SUI TRUMP", b"TRUMP", b"TRUMP is a token inspired by the meme culture and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4eISVEIPu9IbZc_IGDW2VGFfJ9oWHve9cLZGY3-gStKeAkHTLyMuaUynN19JWi8DyNoU&usqp=CAU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUI_TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUI_TRUMP>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUI_TRUMP>(&mut v0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_TRUMP>>(v0);
    }

    // decompiled from Move bytecode v6
}

