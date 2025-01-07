module 0x4a747bc2ddeeb5cdcb52b8609eba931171149d43bbeddf1f9f082b003220f67a::stz {
    struct STZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STZ>, arg1: 0x2::coin::Coin<STZ>) {
        0x2::coin::burn<STZ>(arg0, arg1);
    }

    fun init(arg0: STZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STZ>(arg0, 2, b"STZ", b"Suitizen", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.howrea.com/logo192.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mintOnce(arg0: &mut 0x2::coin::TreasuryCap<STZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

