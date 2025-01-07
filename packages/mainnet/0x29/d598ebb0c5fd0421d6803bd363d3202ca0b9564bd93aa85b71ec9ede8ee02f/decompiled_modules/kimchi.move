module 0x29d598ebb0c5fd0421d6803bd363d3202ca0b9564bd93aa85b71ec9ede8ee02f::kimchi {
    struct KIMCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMCHI>(arg0, 2, b"KIMCHI", b"KIMCHI", b"JUST A KIMCHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1747812549616156673/Sn5FAf65_400x400.jpg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIMCHI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KIMCHI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KIMCHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KIMCHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

