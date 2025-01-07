module 0x75bd6ecba74cf47c7f32534dbd9f44e9a8a45e8be558975b54efe0a3ece85523::milady {
    struct MILADY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MILADY>, arg1: 0x2::coin::Coin<MILADY>) {
        0x2::coin::burn<MILADY>(arg0, arg1);
    }

    fun init(arg0: MILADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILADY>(arg0, 9, b"milady", b"ladys", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/6h2JZiY.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILADY>>(v1);
        0x2::coin::mint_and_transfer<MILADY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILADY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MILADY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MILADY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

