module 0x653a8569fcfff89385e6c4eb6c73eea77e563a9f7b568dd8d95bf9daebae5918::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 2, b"BPIKA", b"Baby Pika", b"Baby Pika", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/AUq8UZs.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BABY>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

