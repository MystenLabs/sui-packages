module 0x56dc92494aecb4c5b5c39f981d57f3c673df34a3861c21d509b631aa347266d::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 6, b"BOBO", b"BoboDog Sui", b"$BOBO is the most unique and lucky Dog in the Sui ocean, staying true to its roots and bringing wealth and dynamic energy to the Sui Network. With the lore of the legendary smart dog, symbolizes intelligence and ingenuity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001424_b7da7bda86.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

