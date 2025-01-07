module 0xa9fb70aa2efd5edc4bcb94fcd5a523e50fb01d6771ac1194b432aff0b7b1ec09::NIGGA {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGA>(arg0, 6, b"NIGGA", b"NIGGA", b"LFFFFGGGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/bs5de4v.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NIGGA>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

