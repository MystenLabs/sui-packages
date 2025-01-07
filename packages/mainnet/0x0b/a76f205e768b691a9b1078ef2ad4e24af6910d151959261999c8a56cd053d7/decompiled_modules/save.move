module 0xba76f205e768b691a9b1078ef2ad4e24af6910d151959261999c8a56cd053d7::save {
    struct SAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVE>(arg0, 6, b"SAVE", b"save", b"sosa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/1yVkEUQ.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAVE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

