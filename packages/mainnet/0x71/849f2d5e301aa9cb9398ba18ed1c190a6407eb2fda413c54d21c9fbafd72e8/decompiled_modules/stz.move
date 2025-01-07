module 0x71849f2d5e301aa9cb9398ba18ed1c190a6407eb2fda413c54d21c9fbafd72e8::stz {
    struct STZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STZ>, arg1: 0x2::coin::Coin<STZ>) {
        0x2::coin::burn<STZ>(arg0, arg1);
    }

    fun init(arg0: STZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STZ>(arg0, 5, b"STZ", b"Suitizen", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/rJnMzhr.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STZ>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

