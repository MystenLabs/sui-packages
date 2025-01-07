module 0xa9fb8593b5f5c267d981b676d54d0b3f3b4618225282885d08015bd99b1bb555::soda {
    struct SODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODA>(arg0, 6, b"SODA", b"Sui Yoda", b"May the Pumps Be With You.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_new_a9bd5473b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

