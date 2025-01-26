module 0xbdb61dd88f7d710a5221147fe18d32be421c584709e010f1d4f182d0017e6326::nsfz {
    struct NSFZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSFZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSFZ>(arg0, 6, b"NSFZ", b"NSFuck", b"Nsf fuck all around the Blockchain. Meet me at the hotel room.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012695_7404131458.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSFZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSFZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

