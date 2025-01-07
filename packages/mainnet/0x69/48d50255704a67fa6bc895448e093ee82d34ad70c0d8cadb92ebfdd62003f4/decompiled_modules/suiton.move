module 0x6948d50255704a67fa6bc895448e093ee82d34ad70c0d8cadb92ebfdd62003f4::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITON>, arg1: 0x2::coin::Coin<SUITON>) {
        0x2::coin::burn<SUITON>(arg0, arg1);
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"SUITON", b"SUITON WATER CLAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/clan_wars/images/b/b9/Suiton.jpg/revision/latest?cb=20200518154331")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

