module 0xabac1fd19e711fa51419bc626195d7a858733e04b00a48d761e123e1acc7367c::pufy {
    struct PUFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFY>(arg0, 6, b"PUFY", b"PUFYDOG", b"a nerd puf dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e32721317cac6a95a59c16cb98a01b7f_bde5bafb3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

