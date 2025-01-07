module 0x2d6688b21b32334a087de2de3ad15884574afb08aeb87ea3ad1e27153a37fb34::stz {
    struct STZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STZ>, arg1: 0x2::coin::Coin<STZ>) {
        0x2::coin::burn<STZ>(arg0, arg1);
    }

    fun init(arg0: STZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STZ>(arg0, 2, b"STZ", b"Suitizen", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"http://i.imgur.com/rJnMzhr.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mintOnce(arg0: &mut 0x2::coin::TreasuryCap<STZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

