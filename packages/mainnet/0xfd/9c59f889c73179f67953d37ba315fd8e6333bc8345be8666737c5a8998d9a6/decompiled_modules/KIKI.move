module 0xfd9c59f889c73179f67953d37ba315fd8e6333bc8345be8666737c5a8998d9a6::KIKI {
    struct KIKI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KIKI>, arg1: 0x2::coin::Coin<KIKI>) {
        0x2::coin::burn<KIKI>(arg0, arg1);
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 9, b"KIKI", b"KIKISUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/K7fpxWF/kiki.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KIKI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KIKI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

