module 0x235eec29ffc9f118ed1c5f35e8ef86e8d2ca3f19585529e3aa25ae50017092d7::SOLLY {
    struct SOLLY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOLLY>, arg1: 0x2::coin::Coin<SOLLY>) {
        0x2::coin::burn<SOLLY>(arg0, arg1);
    }

    fun init(arg0: SOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLLY>(arg0, 9, b"SOLLY", b"SOLLY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/NsHKjKN/solly.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOLLY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOLLY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

